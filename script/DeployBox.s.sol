// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployBox is Script {
    BoxV1 public box;

    function setUp() public {}

    function run() public returns(address){

        box = new BoxV1();

        ERC1967Proxy proxy = new ERC1967Proxy(
            address(box),
            abi.encodeWithSignature("initialize()")
        );
        
        return address(proxy);
    }
}