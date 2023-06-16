// SPDX-License-Identifier: ISC
pragma solidity ^0.8.19;

// ====================================================================
// |     ______                   _______                             |
// |    / _____________ __  __   / ____(_____  ____ _____  ________   |
// |   / /_  / ___/ __ `| |/_/  / /_  / / __ \/ __ `/ __ \/ ___/ _ \  |
// |  / __/ / /  / /_/ _>  <   / __/ / / / / / /_/ / / / / /__/  __/  |
// | /_/   /_/   \__,_/_/|_|  /_/   /_/_/ /_/\__,_/_/ /_/\___/\___/   |
// |                                                                  |
// ====================================================================
// ======================= FraxlendWhitelist ==========================
// ====================================================================
// Frax Finance: https://github.com/FraxFinance

// Primary Author
// Drake Evans: https://github.com/DrakeEvans

// Reviewers
// Dennis: https://github.com/denett
// Sam Kazemian: https://github.com/samkazemian
// Travis Moore: https://github.com/FortisFortuna
// Jack Corddry: https://github.com/corddry
// Rich Gee: https://github.com/zer0blockchain

// ====================================================================

import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";

contract FraxlendWhitelist is Ownable2Step {
    /// @notice Fraxlend Deployer Whitelist mapping.
    mapping(address => bool) public fraxlendDeployerWhitelist;

    constructor() Ownable2Step() {}

    /// @notice The ```SetFraxlendDeployerWhitelist``` event fires whenever a status is set for a given address.
    /// @param _address address being set.
    /// @param _bool approval being set.
    event SetFraxlendDeployerWhitelist(address indexed _address, bool _bool);

    /// @notice The ```setFraxlendDeployerWhitelist``` function sets a given address to true/false for use as a custom deployer.
    /// @param _addresses addresses to set status for.
    /// @param _bool status of approval.
    function setFraxlendDeployerWhitelist(address[] calldata _addresses, bool _bool) external onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            fraxlendDeployerWhitelist[_addresses[i]] = _bool;
            emit SetFraxlendDeployerWhitelist(_addresses[i], _bool);
        }
    }
}
