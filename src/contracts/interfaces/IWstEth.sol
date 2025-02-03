// SPDX-License-Identifier: ISC
pragma solidity >=0.8.19;

interface IWstEth {
    function getStETHByWstETH(uint256) external view returns (uint256);
}
