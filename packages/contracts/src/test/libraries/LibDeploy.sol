// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

// NOTE: This file is autogenerated via `mud codegen-libdeploy` from `deploy.json`. Do not edit manually.

// Foundry
import { DSTest } from "ds-test/test.sol";
import { console } from "forge-std/console.sol";

// Solecs
import { World } from "solecs/World.sol";
import { BareComponent } from "solecs/BareComponent.sol";
import { getAddressById } from "solecs/utils.sol";
import { IUint256Component } from "solecs/interfaces/IUint256Component.sol";
import { ISystem } from "solecs/interfaces/ISystem.sol";

// Components (requires 'components=...' remapping in project's remappings.txt)
import { MapConfigComponent, ID as MapConfigComponentID } from "components/MapConfigComponent.sol";

// Systems (requires 'systems=...' remapping in project's remappings.txt)
import { InitSystem, ID as InitSystemID } from "systems/InitSystem.sol";

struct DeployResult {
  World world;
  address deployer;
}

library LibDeploy {
  function deploy(
    address _deployer,
    address _world,
    bool _reuseComponents,
    uint32 width,
    uint32 height
  ) internal returns (DeployResult memory result) {
    result.deployer = _deployer;

    // ------------------------
    // Deploy
    // ------------------------

    // Deploy world
    result.world = _world == address(0) ? new World() : World(_world);
    if (_world == address(0)) result.world.init(); // Init if it's a fresh world

    // Deploy components
    if (!_reuseComponents) {
      BareComponent comp;

      console.log("Deploying MapConfigComponent");
      comp = new MapConfigComponent(address(result.world), width, height);
      console.log(address(comp));
    }

    // Deploy systems
    deploySystems(address(result.world), true);
  }

  function authorizeWriter(
    IUint256Component components,
    uint256 componentId,
    address writer
  ) internal {
    BareComponent(getAddressById(components, componentId)).authorizeWriter(writer);
  }

  /**
   * Deploy systems to the given world.
   * If `init` flag is set, systems with `initialize` setting in `deploy.json` will be executed.
   */
  function deploySystems(address _world, bool init) internal {
    World world = World(_world);
    // Deploy systems
    ISystem system;
    IUint256Component components = world.components();

    console.log("Deploying InitSystem");
    system = new InitSystem(world, address(components));
    world.registerSystem(address(system), InitSystemID);
    authorizeWriter(components, MapConfigComponentID, address(system));
    console.log(address(system));
  }
}
