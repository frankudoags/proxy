// SPDX-License-Identifier: MIT 
pragma solidity 0.8.24;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV2 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 private value;

        /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public reinitializer(2) {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
    }

    function store(uint256 newValue) public {
        value = newValue;
    }

    function retrieve() public view returns (uint256) {
        return value;
    }

    function version() public pure returns (string memory) {
        return "V2";
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}