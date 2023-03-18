import { setupMUDNetwork } from "@latticexyz/std-client";
import { createWorld, getComponentValue } from "@latticexyz/recs";
import { SystemTypes } from "contracts/types/SystemTypes";
import { SystemAbis } from "contracts/types/SystemAbis.mjs";
import { defineNumberComponent } from "@latticexyz/std-client";
import { config } from "./mud/config";
import { readFileSync } from "fs";
import { ethers } from "ethers";
import { setup } from "./mud/setup";
// The world contains references to all entities, all components and disposers.

const one = "01";
const two = "02";
const three = "03";
const data = ethers.utils.hexlify(
  Array(2000).fill(1).concat(Array(5000).fill(2)).concat(Array(3000).fill(3))
);

//console.log(data);
// Components contain the application state.
// If a contractId is provided, MUD syncs the state with the corresponding
// component contract (in this case `CounterComponent.sol`)

/*// Components expose a stream that triggers when the component is updated.
components.MapConfig.update$.subscribe(({ value }) => {
  document.getElementById("counter")!.innerHTML = String(value?.[0]?.terrain);
});*/

const { components, singletonEntity, singletonEntityId, systems } =
  await setup();

(window as any).increment = async () => {
  const tx = await systems["system.Init"].execute(data);
  await tx.wait();
  console.log(getComponentValue(components.MapConfig, singletonEntity));
};
