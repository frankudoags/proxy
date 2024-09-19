// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {Box} from "../src/BoxProxy.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";



contract BoxTest is Test {
    BoxV1 public boxV1;
    BoxV2 public boxV2;
     Box public proxy;

     error UUPSUnauthorizedCallContext();
     error InvalidInitialization();



    function setUp() public {
        boxV1 = new BoxV1();
        proxy = new Box(address(boxV1), abi.encodeWithSignature("initialize()"));
    }

    function testValue() public {
        //check if the value is stored
        assertEq(BoxV1(address(proxy)).retrieve(), uint256(1));

        //check version
        assertEq(BoxV1(address(proxy)).version(), string("V1"));
    }

    function testUpgrade() public {

        boxV2 = new BoxV2();
        BoxV1(address(proxy)).upgradeToAndCall(address(boxV2), abi.encodeWithSignature("initialize()"));

        //call store with value 50 on proxy
        BoxV2(address(proxy)).store(50);

        // check if the value is stored
        assertEq(BoxV2(address(proxy)).retrieve(), uint256(50));


        //check that cannot reinitialize
        vm.expectRevert(InvalidInitialization.selector);
        BoxV1(address(proxy)).initialize();

        //check version
        assertEq(BoxV2(address(proxy)).version(), string("V2"));
    }

}