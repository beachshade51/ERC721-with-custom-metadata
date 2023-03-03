// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract myNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    string private _baseTokenURI;

    constructor(string memory baseTokenURI) ERC721("sid's NFT", "XID") {
        _baseTokenURI = baseTokenURI;
    }

    function safeMint() public {
        require(
            !_exists(_tokenIdCounter.current()),
            "user already has one NFT"
        );

        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(msg.sender, tokenId);
        _tokenIdCounter.increment();
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        string memory _tokenURI = string(
            abi.encodePacked(_baseURI(), "/", tokenId, ".json")
        );
        return _tokenURI;
    }
}
