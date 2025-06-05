// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StakeTask} from "../src/StakeTask.sol";

contract StakeTaskTest is Test {
    StakeTask public stakeTask;

    function setUp() public {
        stakeTask = new StakeTask();
    }

    function testCreateTask() public {
        vm.prank(address(1));
        vm.deal(address(1), 1 ether);

        vm.expectEmit(true, false, false, true);
        emit StakeTask.TaskCreated(0, "test", 1 ether, address(1));

        stakeTask.createTask{value: 1 ether}("test");

        StakeTask.Task memory task = stakeTask.getTask(0);

        assertEq(task.id, 0);
        assertEq(task.description, "test");
        assertEq(task.stakeAmount, 1 ether);
        assertEq(task.createAt, block.timestamp);
        assertEq(task.creator, address(1));
        assertEq(task.completed, false);

        // Verifica saldo do contrato
        assertEq(address(stakeTask).balance, 1 ether);
    }

    function testCompleteTaskOnlyByCreator() public {
        vm.deal(address(1), 1 ether);
        vm.prank(address(1));
        stakeTask.createTask{value: 1 ether}("test");

        vm.prank(address(2));
        vm.expectRevert(StakeTask.OnlyCreatorCanComplete.selector);
        stakeTask.completeTask(0);
    }

    function testCompleteTaskAlreadyCompleted() public {
        vm.deal(address(1), 1 ether);
        vm.startPrank(address(1));
        stakeTask.createTask{value: 1 ether}("test");
        stakeTask.completeTask(0);

        vm.expectRevert(StakeTask.TaskAlreadyCompleted.selector);
        stakeTask.completeTask(0);
        vm.stopPrank();
    }

    function testCompleteTaskNonExistent() public {
        vm.prank(address(1));
        vm.expectRevert(StakeTask.TaskDoesNotExist.selector);
        stakeTask.completeTask(0);
    }

    function testCompleteTaskSuccessfully() public {
        vm.deal(address(1), 1 ether);
        vm.prank(address(1));
        stakeTask.createTask{value: 1 ether}("test");

        vm.expectEmit(true, false, false, true);
        emit StakeTask.TaskCompleted(0, address(1));

        vm.prank(address(1));
        stakeTask.completeTask(0);

        StakeTask.Task memory task = stakeTask.getTask(0);
        assertEq(task.completed, true);
    }

    function testGetTaskValid() public {
        vm.deal(address(1), 1 ether);
        vm.prank(address(1));
        stakeTask.createTask{value: 1 ether}("test");

        StakeTask.Task memory task = stakeTask.getTask(0);
        assertEq(task.description, "test");
    }

    function testGetTaskInvalid() public {
        vm.expectRevert(StakeTask.TaskDoesNotExist.selector);
        stakeTask.getTask(0);
    }

    function testMultipleTasksAndBalance() public {
        vm.deal(address(1), 2 ether);
        vm.deal(address(2), 1 ether);

        vm.prank(address(1));
        stakeTask.createTask{value: 1 ether}("task1");

        vm.prank(address(2));
        stakeTask.createTask{value: 1 ether}("task2");

        assertEq(address(stakeTask).balance, 2 ether);

        StakeTask.Task memory task1 = stakeTask.getTask(0);
        StakeTask.Task memory task2 = stakeTask.getTask(1);

        assertEq(task1.creator, address(1));
        assertEq(task2.creator, address(2));
        assertEq(task1.stakeAmount, 1 ether);
        assertEq(task2.stakeAmount, 1 ether);
    }
}
