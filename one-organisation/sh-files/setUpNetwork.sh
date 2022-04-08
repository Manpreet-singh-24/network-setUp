# Manually generate the Certificates
#echo '####################################################'
#echo 'Deleted crypto-config directory'
#echo '####################################################'
#rm -rf first-network/crypto-config

# Manually generate the Certificates
#echo '####################################################'
#echo 'Deleted channel-artifacts files'
#echo '####################################################'
#rm -rf first-network/channel-artifacts/*.tx
#rm -rf first-network/channel-artifacts/*.block

# Manually generate the Certificates
echo '####################################################'
echo 'Manually generate the Certificates'
echo '####################################################'
../bin/cryptogen generate --config=./crypto-config.yaml

# Set configtx.yaml file path
echo '####################################################'
echo 'Set configtx.yaml file path'
echo '####################################################'
export FABRIC_CFG_PATH=$PWD


# Create the orderer genesis block
echo '####################################################'
echo 'Create the orderer genesis block'
echo '####################################################'
../bin/configtxgen -profile TwoOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block


# Create a Channel Configuration Transaction
echo '####################################################'
echo 'Create a Channel Configuration Transaction'
echo '####################################################'
export CHANNEL_NAME=mychannel  && ../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME


# Define the anchor peer for Org1
echo '####################################################'
echo 'Define the anchor peer for Org1'
echo '####################################################'
../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/TcsMSPanchors.tx -channelID $CHANNEL_NAME -asOrg TcsMSP


# Define the anchor peer for Org2
# echo '####################################################'
# echo 'Define the anchor peer for Org2'
# echo '####################################################'
# ../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/WiproMSPanchors.tx -channelID $CHANNEL_NAME -asOrg WiproMSP


# Start the network
echo '####################################################'
echo 'Start the network'
echo '####################################################'
docker-compose -f docker-compose-cli.yaml up -d



# Enter the CLI container using the docker exec
echo '####################################################'
echo 'Enter the CLI container using the docker exec'
echo '####################################################'
docker exec -it cli bash