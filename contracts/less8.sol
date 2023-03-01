// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

      // Merkle tree

    //       ROOT
    //   H1-2     H3-4
    // H1   H2  H3  H4
    // TX1  TX2 TX3 TX4

contract Tree {

    bytes32[] public hashes;
    string[4] transactions = [
        "TX1: Sherlock -> John",
        "TX2: John -> Sherlock",
        "TX3: John -> Mary",
        "TX4: Mary -> Sherlock"
    ];

    constructor() {
        for(uint i = 0; i < transactions.length; i++) {
            hashes.push(makeHash(transactions[i]));
        }

        uint count = transactions.length;
        uint offset = 0;

        while(count > 0) {
            for(uint i = 0; i < count - 1; i += 2) {
                hashes.push(keccak256(
                    abi.encodePacked(
                        hashes[offset + i], hashes[offset + i + 1]
                    )
                ));
            }
            offset += count;
            count = count / 2;
        }
    }

    function verify(string memory transaction, uint index, bytes32 root, bytes32[] memory proof) public pure returns(bool) {
        bytes32 hash = makeHash(transaction);
        for(uint i = 0; i < proof.length; i++) {
            bytes32 element = proof[i];
            if(index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, element));
            } else {
                hash = keccak256(abi.encodePacked(element, hash));
            }
            index = index / 2;
        }
        return hash == root;
    }

    function encode(string memory input) public pure returns(bytes memory) {
        return abi.encodePacked(input);
        //не знаем конечную длину массива, она зависит от введенных данных, потому bytes memory
    }

    function makeHash(string memory input) public pure returns(bytes32) {
        // возвращает хэш, мы знаем, сколько он займет, потому bytes32
        return keccak256(
            encode(input)
        );
    }
}

//test verify
//transaction "TX3: John -> Mary"
//index 2
//root 0x09b224c621fb4ff030cb745cf19402c0a25ffb707b359ace8780aeeacb0ac988
//proof 0x69a40d72d1258df801a7ae1e36dd586717a112334f8d9ca4664a339168874ef5, 
    //  0x58e9a664a4c1e26694e09437cad198aebc6cd3c881ed49daea6e83e79b77fead


