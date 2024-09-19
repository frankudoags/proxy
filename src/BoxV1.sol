// SPDX-License-Identifier: MIT 
pragma solidity 0.8.24;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 private value;
    
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();
        value = 1; // Set an initial value
    }

    function retrieve() public view returns (uint256) {
        return value;
    }

    function version() public pure returns (string memory) {
        return "V1";
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}