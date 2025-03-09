// SPDX-License-Identifier: The Unlicense
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";

import {FraxlendPair} from "../src/contracts/FraxlendPair.sol";
import {FraxlendWhitelist} from "../src/contracts/FraxlendWhitelist.sol";
import {FraxlendPairRegistry} from "../src/contracts/FraxlendPairRegistry.sol";
import {FraxlendPairDeployer, ConstructorParams} from "../src/contracts/FraxlendPairDeployer.sol";

contract DeployFraxlend is Script {
    FraxlendWhitelist whitelist;
    FraxlendPairRegistry registry;
    FraxlendPairDeployer pairDeployer;

    function run() public virtual {
        vm.startBroadcast();

        console2.log("Deploying `FraxlendWhitelist`...\n");
        whitelist = new FraxlendWhitelist();
        console2.log("`FraxlendWhitelist`: ", address(whitelist), "\n");

        console2.log("Deploying `FraxlendPairRegistry`...\n");
        registry = new FraxlendPairRegistry(msg.sender, new address[](0));
        console2.log("`FraxlendPairRegistry`: ", address(registry), "\n");

        console2.log("Deploying `FraxlendPairDeployer`...\n");
        pairDeployer = new FraxlendPairDeployer(
            ConstructorParams(
                vm.envAddress("FRAXLEND_CIRCUIT_BREAKER"),
                vm.envAddress("FRAXLEND_COMPTROLLER"),
                vm.envAddress("FRAXLEND_TIMELOCK"),
                address(whitelist),
                address(registry)
            )
        );
        console2.log("`FraxlendPairDeployer`: ", address(pairDeployer), "\n");

        pairDeployer.setCreationCode(type(FraxlendPair).creationCode);

        address[] memory deployers = new address[](1);
        deployers[0] = msg.sender;

        registry.setDeployers(deployers, true);
        whitelist.setFraxlendDeployerWhitelist(deployers, true);

        vm.stopBroadcast();
    }
}
