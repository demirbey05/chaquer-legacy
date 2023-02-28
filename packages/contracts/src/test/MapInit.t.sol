//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import { Deploy } from "./Deploy.sol";
import "std-contracts/test/MudTest.t.sol";
import { console } from "forge-std/console.sol";
import { MapConfigComponent, ID as MapConfigComponentID } from "components/MapConfigComponent.sol";
import { InitSystem, ID as InitSystemID } from "systems/InitSystem.sol";

contract MapInitTest is MudTest {
  constructor() MudTest(new Deploy()) {}

  function testEnterTerrain() public {
    bytes
      memory terrains = hex"03030303030303030303030303030303030303030303030303020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020201010101010101010101010101010101010101010101010101";

    InitSystem init = InitSystem(system(InitSystemID));

    init.executeTyped(10, 10, terrains);

    MapConfigComponent mapConfig = MapConfigComponent(component(MapConfigComponentID));
    uint256 tryNumber = 3;
    bytes1 tileSample = mapConfig.getTerrainValue(tryNumber);
    assertEq(tileSample, terrains[tryNumber]);
  }

  function testFailSettedMapCannotBeChanged() public {
    uint256 tryNumber = 3;
    bytes
      memory terrains1 = hex"03030303030303030303030303030303030303030303030303020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020201010101010101010101010101010101010101010101010101";
    bytes
      memory terrains2 = hex"01010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101";
    InitSystem init = InitSystem(system(InitSystemID));

    init.executeTyped(10, 10, terrains1);
    init.executeTyped(10, 10, terrains2);

    MapConfigComponent mapConfig = MapConfigComponent(component(MapConfigComponentID));
    bytes1 tileSample = mapConfig.getTerrainValue(tryNumber);
    assertEq(tileSample, terrains2[tryNumber]);
  }
}
