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

contract MapInitScript is Script {
  World world;

  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);

    World world = World(0xf932D52334e9FB7552a71cbE3786717569c21941);
    IUint256Component systems = world.systems();

    IUint256Component components = world.components();
    InitSystem initSystem = InitSystem(getAddressById(systems, InitSystemID));
    MapConfigComponent mapConfig = MapConfigComponent(getAddressById(components, MapConfigComponentID));

    bytes memory map = bytes(vm.readFile("scripts/mock_data/data1.txt"));
    initSystem.execute(map);
    vm.stopBroadcast();

    vm.startBroadcast(deployerPrivateKey);
    map = bytes(vm.readFile("scripts/mock_data/my_file.txt"));
    initSystem.execute(map);
    vm.stopBroadcast();

    if (map[3] == mapConfig.getTerrain(5003)) {
      console.log("OK");
    }
    console.log(mapConfig.currentTerrainLength());
  }
}
