//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import { System, IWorld } from "solecs/System.sol";
import { getAddressById } from "solecs/utils.sol";
import { MapConfigComponent, ID as MapConfigComponentID } from "components/MapConfigComponent.sol";

uint256 constant ID = uint256(keccak256("system.Init"));

contract InitSystem is System {
  uint256 constant width = 100;
  uint256 constant height = 100;

  constructor(IWorld _world, address _components) System(_world, _components) {}

  function execute(bytes memory terrain) public returns (bytes memory) {
    MapConfigComponent terrainComponent = MapConfigComponent(getAddressById(components, MapConfigComponentID));
    if ((terrainComponent.getTerrainLength()) == width * height) {
      return new bytes(0);
    }
    terrainComponent.set(terrain);
  }
}
