// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19;

interface IVariableInterestRateV2 {
    function MAX_FULL_UTIL_RATE() external view returns (uint256);

    function MAX_TARGET_UTIL() external view returns (uint256);

    function MIN_FULL_UTIL_RATE() external view returns (uint256);

    function MIN_TARGET_UTIL() external view returns (uint256);

    function RATE_HALF_LIFE() external view returns (uint256);

    function RATE_PREC() external view returns (uint256);

    function UTIL_PREC() external view returns (uint256);

    function VERTEX_RATE_PERCENT() external view returns (uint256);

    function VERTEX_UTILIZATION() external view returns (uint256);

    function ZERO_UTIL_RATE() external view returns (uint256);

    function getNewRate(
        uint256 _deltaTime,
        uint256 _utilization,
        uint64 _oldFullUtilizationInterest
    ) external view returns (uint64 _newRatePerSec, uint64 _newFullUtilizationInterest);

    function name() external pure returns (string memory);

    function version() external pure returns (uint256 _major, uint256 _minor, uint256 _patch);
}
