//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import { System, IWorld } from "solecs/System.sol";
import { getAddressById } from "solecs/utils.sol";
import { MapConfigComponent, ID as MapConfigComponentID, MapConfig } from "components/MapConfigComponent.sol";
uint256 constant ID = uint256(keccak256("system.Init"));

contract InitSystem is System {
  constructor(IWorld _world, address _components) System(_world, _components) {}

  function execute(bytes memory args) public returns (bytes memory) {
    (uint32 width, uint32 height, bytes memory terrain) = abi.decode(args, (uint32, uint32, bytes));

    executeTyped(width, height, terrain);
  }

  function executeTyped(
    uint32 width,
    uint32 height,
    bytes memory terrain
  ) public returns (bytes memory) {
    MapConfigComponent terrainComponent = MapConfigComponent(getAddressById(components, MapConfigComponentID));
    if ((terrainComponent.isSet()) == true) {
      return new bytes(0);
    }
    terrainComponent.set(MapConfig(width, height, terrain));
  }
}
