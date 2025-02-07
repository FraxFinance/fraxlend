// SPDX-License-Identifier: ISC
pragma solidity >=0.8.19;

// NOTE: This file generated from https://etherscan.io/address/0x8412ebf45bAC1B340BbE8F318b928C466c4E39CA#code

interface ITimelock {
    event NewAdmin(address indexed newAdmin);
    event NewPendingAdmin(address indexed newPendingAdmin);
    event NewDelay(uint indexed newDelay);
    event CancelTransaction(
        bytes32 indexed txHash,
        address indexed target,
        uint value,
        string signature,
        bytes data,
        uint eta
    );
    event ExecuteTransaction(
        bytes32 indexed txHash,
        address indexed target,
        uint value,
        string signature,
        bytes data,
        uint eta
    );
    event QueueTransaction(
        bytes32 indexed txHash,
        address indexed target,
        uint value,
        string signature,
        bytes data,
        uint eta
    );

    function GRACE_PERIOD() external view returns (uint256);

    function MAXIMUM_DELAY() external view returns (uint256);

    function MINIMUM_DELAY() external view returns (uint256);

    function acceptAdmin() external;

    function admin() external view returns (address);

    function cancelTransaction(
        address target,
        uint256 value,
        string memory signature,
        bytes memory data,
        uint256 eta
    ) external;

    function delay() external view returns (uint256);

    function executeTransaction(
        address target,
        uint256 value,
        string memory signature,
        bytes memory data,
        uint256 eta
    ) external returns (bytes memory);

    function pendingAdmin() external view returns (address);

    function queueTransaction(
        address target,
        uint256 value,
        string memory signature,
        bytes memory data,
        uint256 eta
    ) external returns (bytes32);

    function queuedTransactions(bytes32) external view returns (bool);

    function setDelay(uint256 delay_) external;

    function setPendingAdmin(address pendingAdmin_) external;
}
