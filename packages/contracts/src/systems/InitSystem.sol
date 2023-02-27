//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import { System, IWorld } from "solecs/System.sol";
import { getAddressById } from "solecs/utils.sol";
import { TerrainComponent, ID as TerrainComponentID } from "components/TerrainComponent.sol";
uint256 constant ID = uint256(keccak256("system.Init"));

contract InitSystem is System {
  constructor(IWorld _world, address _components) System(_world, _components) {}

  function execute(bytes memory args) public returns (bytes memory) {
    (uint256 coord_x, uint256 coord_y, uint8 terrain) = abi.decode(args, (uint256, uint256, uint8));

    executeTyped(coord_x, coord_y, terrain);
  }

  function executeTyped(
    uint256 coord_x,
    uint256 coord_y,
    uint8 terrain
  ) public returns (bytes memory) {
    TerrainComponent terrainComponent = TerrainComponent(getAddressById(components, TerrainComponentID));
    uint256 entityID = uint256(keccak256(abi.encodePacked(coord_x, ",", coord_y)));
    if (terrainComponent.has(entityID) == true) {
      return new bytes(0);
    }
    terrainComponent.set(entityID, terrain);
  }
}
