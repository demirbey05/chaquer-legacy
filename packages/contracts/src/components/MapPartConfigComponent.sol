//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import { BareComponent } from "solecs/BareComponent.sol";
import { LibTypes } from "solecs/LibTypes.sol";

uint256 constant ID = uint256(keccak256("component.MapPartConfig"));

struct MapConfig {
  uint32 width;
  uint32 height;
  bytes terrain;
}

contract MapPartConfigComponent is BareComponent {
  constructor(address world) BareComponent(world, ID) {}

  function getSchema() public pure override returns (string[] memory keys, LibTypes.SchemaValue[] memory values) {
    keys = new string[](3);
    values = new LibTypes.SchemaValue[](3);

    keys[0] = "width";
    values[0] = LibTypes.SchemaValue.UINT32;

    keys[1] = "height";
    values[1] = LibTypes.SchemaValue.UINT32;

    keys[2] = "terrain";
    values[2] = LibTypes.SchemaValue.STRING;
  }

  function set(uint256 entity, MapConfig calldata value) public virtual {
    set(entity, abi.encode(value));
  }

  function getValue(uint256 entity) public view virtual returns (MapConfig memory) {
    (uint32 width, uint32 height, bytes memory terrain) = abi.decode(getRawValue(entity), (uint32, uint32, bytes));
    return MapConfig(width, height, terrain);
  }
}
