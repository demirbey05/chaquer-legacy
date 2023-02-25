//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import { System, IWorld } from "solecs/System.sol";
import { getAddressById } from "solecs/utils.sol";
import { MapPartConfigComponent, ID as MapPartConfigComponentID, MapConfig } from "components/MapPartConfigComponent.sol";
uint256 constant ID = uint256(keccak256("system.Init"));

contract InitSystem is System {
  constructor(IWorld _world, address _components) System(_world, _components) {}

  function execute(bytes memory args) public returns (bytes memory) {
    (uint256 entityId, uint32 width, uint32 height, bytes memory terrain) = abi.decode(
      args,
      (uint256, uint32, uint32, bytes)
    );
    MapConfig memory config = MapConfig(width, height, terrain);
    executeTyped(entityId, config);
  }

  function executeTyped(uint256 entityId, MapConfig memory config) public returns (bytes memory) {
    MapPartConfigComponent mapConfig = MapPartConfigComponent(getAddressById(components, MapPartConfigComponentID));
    if (mapConfig.has(entityId) == true) {
      return new bytes(0);
    }
    mapConfig.set(entityId, abi.encode(config.width, config.height, config.terrain));
  }
}
