// SPDX-License-Identifier: ISC
pragma solidity >=0.8.13;

interface IFraxlendWhitelist {
    function TIME_LOCK_ADDRESS() external view returns (address);

    function COMPTROLLER_ADDRESS() external view returns (address);

    function oracleContractWhitelist(address) external view returns (bool);

    function rateContractWhitelist(address) external view returns (bool);

    function fraxlendDeployerWhitelist(address) external view returns (bool);

    function setOracleContractWhitelist(address[] calldata _address, bool _bool) external;

    function setRateContractWhitelist(address[] calldata _address, bool _bool) external;

    function setFraxlendDeployerWhitelist(address[] calldata _address, bool _bool) external;
}
