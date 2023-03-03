pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract myNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    mapping(address => uint8) userToTokenAmount;

    constructor() ERC721("sid's NFT", "XID") {
        _tokenIdCounter.increment();
    }

    function safeMint() public {
        require(userToTokenAmount[msg.sender] < 1, "user already has one NFT");

        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(msg.sender, tokenId);
        _tokenIdCounter.increment();
    }

    function _baseURI() internal pure override returns (string memory) {
        return "IPFS";
    }

    function tokenURL(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        string memory _tokenURL = string(
            abi.encodePacked(_baseURI(), "/", tokenId, ".json")
        );
        return _tokenURL;
    }
}
