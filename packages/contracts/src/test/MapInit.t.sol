//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import { Deploy } from "./Deploy.sol";
import "std-contracts/test/MudTest.t.sol";
import { console } from "forge-std/console.sol";
import { TerrainComponent, ID as TerrainComponentID } from "components/TerrainComponent.sol";
import { InitSystem, ID as InitSystemID } from "systems/InitSystem.sol";

contract MapInitTest is MudTest {
  constructor() MudTest(new Deploy()) {}

  function testEnter30Tile() public {
    uint8[30] memory terrains = [
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      2,
      1,
      3,
      1,
      1,
      1,
      1,
      3,
      3,
      1,
      1,
      3,
      1,
      1,
      1,
      1
    ];

    InitSystem init = InitSystem(system(InitSystemID));
    for (uint256 i = 0; i < 15; i++) {
      init.executeTyped(i, i, terrains[i]);
    }

    TerrainComponent terrainComponent = TerrainComponent(component(TerrainComponentID));
    uint256 tryNumber = 3;
    uint8 tileSample = terrainComponent.getValue(uint256(keccak256(abi.encodePacked(tryNumber, ",", tryNumber))));

    assertEq(tileSample, terrains[tryNumber]);
  }
}
