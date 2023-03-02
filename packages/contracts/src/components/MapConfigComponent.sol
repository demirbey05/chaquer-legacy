// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { BareComponent } from "solecs/BareComponent.sol";
import { LibTypes } from "solecs/LibTypes.sol";

uint256 constant SingletonID = 0x60D;

uint256 constant ID = uint256(keccak256("component.MapConfig"));

contract MapConfigComponent is BareComponent {
  uint256 public currentTerrainLength;
  uint32 public immutable width;
  uint32 public immutable height;

  constructor(
    address world,
    uint32 _width,
    uint32 _height
  ) BareComponent(world, ID) {
    width = _width;
    height = _height;
  }

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

  function isSet() public view returns (bool) {
    return width * height == currentTerrainLength;
  }

  function set(bytes memory terrainPart) public {
    entityToValue[SingletonID] = abi.encodePacked(entityToValue[SingletonID], terrainPart);
    currentTerrainLength = currentTerrainLength + terrainPart.length;
  }

  function getValue() public view returns (bytes memory) {
    return getRawValue(SingletonID);
  }

  function getTerrain(uint256 index) public view returns (bytes1) {
    bytes memory data = getValue();
    return data[index];
  }
}
