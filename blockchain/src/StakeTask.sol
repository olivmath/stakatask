// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract StakeTask {
    error OnlyCreatorCanComplete();
    error TaskAlreadyCompleted();
    error TaskDoesNotExist();

    event TaskCreated(
        uint256 indexed taskId,
        string description,
        uint256 stakeAmount,
        address indexed creator
    );
    event TaskCompleted(uint256 indexed taskId, address indexed completer);

    struct Task {
        uint256 id;
        string description;
        uint256 stakeAmount;
        uint256 createAt;
        address creator;
        bool completed;
    }

    constructor() {}

    Task[] public tasks;

    function createTask(
        string memory _description
    ) public payable {
        uint256 taskId = tasks.length;
        Task memory newTask = Task({
            id: taskId,
            description: _description,
            stakeAmount: msg.value,
            createAt: block.timestamp,
            creator: msg.sender,
            completed: false
        });
        tasks.push(newTask);

        emit TaskCreated(taskId, _description, msg.value, msg.sender);
    }

    function completeTask(uint256 _taskId) public {
        if (_taskId >= tasks.length) {
            revert TaskDoesNotExist();
        }

        Task storage task = tasks[_taskId];

        if (task.completed) {
            revert TaskAlreadyCompleted();
        }
        if (msg.sender != task.creator) {
            revert OnlyCreatorCanComplete();
        }

        task.completed = true;

        emit TaskCompleted(_taskId, msg.sender);
    }

    function getTask(uint256 _taskId) public view returns (Task memory) {
        if (_taskId >= tasks.length) {
            revert TaskDoesNotExist();
        } else {
            return tasks[_taskId];
        }
    }

    function getTasksCount() public view returns (uint256) {
        return tasks.length;
    }
}
