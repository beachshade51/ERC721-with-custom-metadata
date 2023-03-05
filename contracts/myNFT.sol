// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract myNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("sid's NFT", "XID") {}

    function safeMint() public {
        require(
            !_exists(_tokenIdCounter.current()),
            "user already has one NFT"
        );

        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(msg.sender, tokenId);
        _tokenIdCounter.increment();
    }

    function _baseURI() internal pure override returns (string memory) {
        return
            "https://bafybeiaktykjqbfagyy6qsxp54rctadowseaadcyrgaqi7asvmwyeiwgmu.ipfs.nftstorage.link";
    }

    function tokenURI(uint256 tokenId)
        public
        pure
        override
        returns (string memory)
    {
        string memory _tokenURI = string(
            abi.encodePacked(
                _baseURI(),
                "/",
                Strings.toString(tokenId),
                ".json"
            )
        );
        return _tokenURI;
    }
}
