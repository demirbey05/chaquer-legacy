//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import { Deploy } from "./Deploy.sol";
import "std-contracts/test/MudTest.t.sol";
import { console } from "forge-std/console.sol";
import { CastleSettleSystem, ID as CastleSettleSystemID, MapIsNotReady, CoordinatesOutOfBound, TileIsNotEmpty, WrongTerrainType, NoCastleRight } from "systems/CastleSettleSystem.sol";
import { MapConfigComponent, ID as MapConfigComponentID } from "components/MapConfigComponent.sol";
import { InitSystem, ID as InitSystemID } from "systems/InitSystem.sol";
import { CastleOwnableComponent, ID as CastleOwnableComponentID } from "components/CastleOwnableComponent.sol";
import { PositionComponent, ID as PositionComponentID, Coord } from "components/PositionComponent.sol";

contract CastleSettleTest is MudTest {
  constructor() MudTest(new Deploy()) {}

  function testMapIsNotReady() public {
    CastleSettleSystem settleSystem = CastleSettleSystem(getAddressById(systems, CastleSettleSystemID));
    MapConfigComponent mapConfig = MapConfigComponent(getAddressById(components, MapConfigComponentID));
    console.log(mapConfig.getTerrainLength());
    vm.expectRevert(MapIsNotReady.selector);
    settleSystem.executeTyped(3, 5);
  }

  function testCoordinatesOutOfBound() public {
    CastleSettleSystem settleSystem = CastleSettleSystem(getAddressById(systems, CastleSettleSystemID));
    InitSystem initSystem = InitSystem(getAddressById(systems, InitSystemID));
    MapConfigComponent mapConfig = MapConfigComponent(getAddressById(components, MapConfigComponentID));
    bytes memory mapData = bytes(vm.readFile("src/test/mock_data/full_data.txt"));
    console.log("Before Init");
    console.log(mapConfig.getTerrainLength());
    initSystem.execute(mapData);
    console.log("After Init");
    console.log(mapConfig.getTerrainLength());
    vm.expectRevert(CoordinatesOutOfBound.selector);
    settleSystem.executeTyped(300, 400);
  }

  function testTileIsNotEmpty() public {
    CastleSettleSystem settleSystem = CastleSettleSystem(getAddressById(systems, CastleSettleSystemID));
    InitSystem initSystem = InitSystem(getAddressById(systems, InitSystemID));
    bytes memory mapData = bytes(vm.readFile("src/test/mock_data/full_data.txt"));
    initSystem.execute(mapData);
    settleSystem.executeTyped(3, 4);
    vm.startPrank(alice);
    vm.expectRevert(TileIsNotEmpty.selector);
    settleSystem.executeTyped(3, 4);
    vm.stopPrank();
  }

  function testWrongTerrainType() public {
    CastleSettleSystem settleSystem = CastleSettleSystem(getAddressById(systems, CastleSettleSystemID));
    InitSystem initSystem = InitSystem(getAddressById(systems, InitSystemID));
    bytes memory mapData = bytes(vm.readFile("src/test/mock_data/full_data.txt"));
    initSystem.execute(mapData);
    vm.expectRevert(WrongTerrainType.selector);
    settleSystem.executeTyped(99, 99);
    vm.stopPrank();
  }

  function testNoCastleRight() public {
    CastleSettleSystem settleSystem = CastleSettleSystem(getAddressById(systems, CastleSettleSystemID));
    InitSystem initSystem = InitSystem(getAddressById(systems, InitSystemID));
    bytes memory mapData = bytes(vm.readFile("src/test/mock_data/full_data.txt"));
    initSystem.execute(mapData);
    settleSystem.executeTyped(3, 4);
    vm.expectRevert(NoCastleRight.selector);
    settleSystem.executeTyped(5, 7);
    vm.stopPrank();
  }

  function testTwoSuccessCastleSettle() public {
    CastleSettleSystem settleSystem = CastleSettleSystem(getAddressById(systems, CastleSettleSystemID));
    InitSystem initSystem = InitSystem(getAddressById(systems, InitSystemID));
    CastleOwnableComponent castleOwnable = CastleOwnableComponent(getAddressById(components, CastleOwnableComponentID));
    PositionComponent position = PositionComponent(getAddressById(components, PositionComponentID));

    bytes memory mapData = bytes(vm.readFile("src/test/mock_data/full_data.txt"));
    initSystem.execute(mapData);

    //Castle Settlement for Alice
    vm.startPrank(alice);
    settleSystem.executeTyped(3, 4);
    uint256 castleOne = castleOwnable.getEntitiesWithValue(alice)[0];
    Coord memory coordOne = position.getValue(castleOne);
    assertEq(alice, castleOwnable.getValue(castleOne));
    assertEq(coordOne.x, 3);
    assertEq(coordOne.y, 4);
    vm.stopPrank();

    //Castle Settlement for Bob
    vm.startPrank(bob);
    settleSystem.executeTyped(10, 2);
    uint256 castleTwo = castleOwnable.getEntitiesWithValue(bob)[0];
    Coord memory coordTwo = position.getValue(castleTwo);
    assertEq(bob, castleOwnable.getValue(castleTwo));
    assertEq(coordTwo.x, 10);
    assertEq(coordTwo.y, 2);
    vm.stopPrank();
  }
}
