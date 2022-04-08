#!/bin/bash

# Set env variables for peer0.org1.example.com
echo '####################################################'
echo 'Set variables for peer0.org1.example.com'
echo '####################################################'
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Tcs.example.com/users/Admin@Tcs.example.com/msp
CORE_PEER_ADDRESS=peer0.Tcs.example.com:7051
CORE_PEER_LOCALMSPID="TcsMSP"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Tcs.example.com/peers/peer0.Tcs.example.com/tls/ca.crt


# Set the channel name
echo '####################################################'
echo 'Set the channel name'
echo '####################################################'
export CHANNEL_NAME=mychannel


# Passing configuration to orderer
echo '####################################################'
echo 'Create Channel'
echo '####################################################'
peer channel create -o orderer.example.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/channel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
    
    output=$?
    if [ $output -ne 0 ]; then 
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
        echo " Channel not created"
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
    else
        echo ' **************************************************** '
        echo "Channel created"    
        echo ' **************************************************** '
    fi 

# Join peer0 of org1 to the channel
echo '####################################################'
echo 'Join peer0 of org1 to the channel'
echo '####################################################'
peer channel join -b mychannel.block

    output=$?
    if [ $output -ne 0 ]; then 
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
        echo " Failed to Join peer0 of org1 to the channel"
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
    else
        echo ' **************************************************** '
        echo " Successfully Join peer0 of org1 to the channel "    
        echo ' **************************************************** '

    fi 

# # Set variables for Org2
# echo '####################################################'
# echo ' Set variables for Org2 '
# echo '####################################################'
# CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/users/Admin@Wipro.example.com/msp CORE_PEER_ADDRESS=peer0.Wipro.example.com:9051 CORE_PEER_LOCALMSPID="WiproMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/peers/peer0.Wipro.example.com/tls/ca.crt peer channel join -b mychannel.block


# Update the anchor peers for Org1
echo '####################################################'
echo ' Update the anchor peers for Org1 '
echo '####################################################'
peer channel update -o orderer.example.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/TcsMSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

    output=$?
    if [ $output -ne 0 ]; then 
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
        echo " Errorrrrr while Update the anchor peers for Org1 "
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
    else
        echo ' **************************************************** '
        echo " Successfully Updated the anchor peers for Org1 "    
        echo ' **************************************************** '
    fi 

# # Update the anchor peers for Org2
# echo '####################################################'
# echo 'Update the anchor peers for Org2'
# echo '####################################################'
# CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/users/Admin@Wipro.example.com/msp CORE_PEER_ADDRESS=peer0.Wipro.example.com:9051 CORE_PEER_LOCALMSPID="WiproMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/peers/peer0.Wipro.example.com/tls/ca.crt peer channel update -o orderer.example.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/WiproMSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem


# Install the Go chaincode.  on peer0 node in Org1
echo '####################################################'
echo ' Install the Go chaincode on peer0 node in Org1 '
echo '####################################################'
peer chaincode install -n mycc -v 1.0 -p github.com/chaincode/chaincode_example02/go/
    
    output=$?
    if [ $output -ne 0 ]; then 
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
        echo " Errorrrrr while Install the Go chaincode "
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
    else
        echo ' **************************************************** '
        echo " Successfully Install the Go chaincode "    
        echo ' **************************************************** '
    fi


# # Modify the following four environment variables t peer0 in Org2
# echo '####################################################'
# echo 'Modify the following four environment variables  peer0 in Org2'
# echo '####################################################'
# CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/users/Admin@Wipro.example.com/msp
# CORE_PEER_ADDRESS=peer0.Wipro.example.com:9051
# CORE_PEER_LOCALMSPID="WiproMSP"
# CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/peers/peer0.Wipro.example.com/tls/ca.crt


# # Install Chaincode onto a peer0 in Org2
# echo '####################################################'
# echo 'Install Chaincode onto a peer0 in Org2'
# echo '####################################################'
# peer chaincode install -n mycc -v 1.0 -p github.com/chaincode/chaincode_example02/go/

#     output=$?
#     if [ $output -ne 0 ]; then 
#         echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
#         echo " Errorrrrr while Install Chaincode onto a peer0 in Org2 "
#         echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
#     else
#         echo ' **************************************************** '
#         echo " Successfully Install Chaincode onto a peer0 in Org2 "    
#         echo ' **************************************************** '
#     fi 


# chaincode instantiate
echo '####################################################'
echo 'chaincode instantiate'
echo '####################################################'
peer chaincode instantiate -o orderer.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C $CHANNEL_NAME -n mycc -v 1.0 -c '{"Args":["init","a", "100", "b","200"]}' -P "AND ('TcsMSP.peer')"

    output=$?
    if [ $output -ne 0 ]; then 
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
        echo " Errorrrrr in chaincode instantiate "
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
    else
        echo ' **************************************************** '
        echo " Successfully chaincode instantiate "    
        echo ' **************************************************** '
    fi 

sleep 10

# Query and Invoke
echo '####################################################'
echo ' Chaincode Query '
echo '####################################################'
peer chaincode query -C $CHANNEL_NAME -n mycc -c '{"Args":["query","a"]}'


    output=$?
    if [ $output -ne 0 ]; then 
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
        echo " Errorrrrr in Chaincode Query line no 159"
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
    else
        echo ' **************************************************** '
        echo " Success block of Chaincode Query "    
        echo ' **************************************************** '
    fi 

sleep 6

# peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C $CHANNEL_NAME -n mycc --peerAddresses peer0.Tcs.example.com:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Tcs.example.com/peers/peer0.Tcs.example.com/tls/ca.crt --peerAddresses peer0.Wipro.example.com:9051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/peers/peer0.Wipro.example.com/tls/ca.crt -c '{"Args":["invoke","a","b","10"]}'


#     output=$?
#     if [ $output -ne 0 ]; then 
#         echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
#         echo " Errorrrrr in chaincode invoke "
#         echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
#     else
#         echo ' **************************************************** '
#         echo " Success block of chaincode invoke "    
#         echo ' **************************************************** '
#     fi 

sleep 6

# peer chaincode query -C $CHANNEL_NAME -n mycc -c '{"Args":["query","a"]}'


#     output=$?
#     if [ $output -ne 0 ]; then 
#         echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
#         echo " Errorrrrr in peer chaincode 222222 "
#         echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
#     else
#         echo ' **************************************************** '
#         echo " Success block peer chaincode 2 "    
#         echo ' **************************************************** '
#     fi 


# # Install the chaincode on a peer1 in Org2 set variables
# echo '####################################################'
# echo 'Install the chaincode on a peer1 in Org2 set variables'
# echo '####################################################'
# CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/users/Admin@Wipro.example.com/msp
# CORE_PEER_ADDRESS=peer1.Wipro.example.com:10051
# CORE_PEER_LOCALMSPID="WiproMSP"
# CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/peers/peer1.Wipro.example.com/tls/ca.crt



# # install the chaincode on a peer1 in Org2
# echo '####################################################'
# echo 'install the chaincode on a peer1 in Org2'
# echo '####################################################'

# peer chaincode install -n mycc -v 1.0 -p github.com/chaincode/chaincode_example02/go/


#     output=$?
#     if [ $output -ne 0 ]; then 
#         echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
#         echo " Errorrrrr in install the chaincode on a peer1 in Org2222 "
#         echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
#     else
#         echo ' **************************************************** '
#         echo " Success install the chaincode on a peer1 in Org2222 "    
#         echo ' **************************************************** '
#     fi 

# CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/users/Admin@Wipro.example.com/msp CORE_PEER_ADDRESS=peer1.Wipro.example.com:10051 CORE_PEER_LOCALMSPID="WiproMSP" CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/Wipro.example.com/peers/peer1.Wipro.example.com/tls/ca.crt peer channel join -b mychannel.block

# peer chaincode query -C $CHANNEL_NAME -n mycc -c '{"Args":["query","a"]}'


#     output=$?
#     if [ $output -ne 0 ]; then 
#         echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
#         echo " Errorrrrr in peer chaincode query333 "
#         echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
#     else
#         echo ' **************************************************** '
#         echo " Success peer chaincode query333 "    
#         echo ' **************************************************** '
#     fi 



# # Exit From peer cli
# echo '####################################################'
# echo 'Exit From peer cli'
# echo '####################################################'
# exit

# # Using CouchDB
# echo '####################################################'
# echo 'Using CouchDB'
# echo '####################################################'
# docker-compose -f docker-compose-cli.yaml -f docker-compose-couch.yaml up -d

# # Enter in the terminal and set channel name
# echo '####################################################'
# echo 'Enter in the terminal'
# echo '####################################################'
# docker exec -it cli bash

sleep 5

export CHANNEL_NAME=mychannel

# Install and instantiate the chaincode on peer0.org1.example.com
echo '####################################################'
echo 'Install and instantiate the chaincode on peer0.org1.example.com'
echo '####################################################'
peer chaincode install -n marbles -v 1.0 -p github.com/chaincode/marbles02/go

    output=$?
    if [ $output -ne 0 ]; then 
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
        echo " Errorrrrr while  Install chaincode  on peer0.org11111111 "
        echo ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ '
    else
        echo ' **************************************************** '
        echo " Successfully Install chaincode  on peer0.org11111111 "    
        echo ' **************************************************** '
    fi