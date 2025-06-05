// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {StakeTask} from "../src/StakeTask.sol";

contract StakeTaskScript is Script {
    StakeTask public stakeTask;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        stakeTask = new StakeTask();

        vm.stopBroadcast();
    }
}
