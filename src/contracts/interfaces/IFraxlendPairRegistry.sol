// SPDX-License-Identifier: ISC
pragma solidity ^0.8.19;

interface IFraxlendPairRegistry {
    event AddPair(address pairAddress);
    event OwnershipTransferStarted(address indexed previousOwner, address indexed newOwner);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event SetDeployer(address deployer, bool _bool);

    function acceptOwnership() external;

    function addPair(address _pairAddress) external;

    function deployedPairsArray(uint256) external view returns (address);

    function deployedPairsByName(string memory) external view returns (address);

    function deployedPairsLength() external view returns (uint256);

    function deployers(address) external view returns (bool);

    function getAllPairAddresses() external view returns (address[] memory _deployedPairsArray);

    function owner() external view returns (address);

    function pendingOwner() external view returns (address);

    function renounceOwnership() external;

    function setDeployers(address[] memory _deployers, bool _bool) external;

    function transferOwnership(address newOwner) external;
}
