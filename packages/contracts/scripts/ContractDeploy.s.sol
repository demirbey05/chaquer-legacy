//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import { World } from "solecs/World.sol";
import { World } from "solecs/World.sol";
import { LibDeploy, DeployResult } from "../src/test/libraries/LibDeploy.sol";
import { IWorld } from "solecs/interfaces/IWorld.sol";
import { MapConfigComponent, ID as MapConfigComponentID } from "components/MapConfigComponent.sol";
import { InitSystem, ID as InitSystemID } from "systems/InitSystem.sol";
import { IUint256Component } from "solecs/interfaces/IUint256Component.sol";
import { getAddressById } from "solecs/utils.sol";

contract ContractDeployScript is Script {
  World world;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);
    DeployResult memory result = LibDeploy.deploy(vm.addr(deployerPrivateKey), address(0), false, 100, 100);
    world = result.world;
    console.log(address(world));
  }
}
