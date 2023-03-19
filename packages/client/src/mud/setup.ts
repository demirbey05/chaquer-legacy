import { setupMUDNetwork } from "@latticexyz/std-client";
import { SytemTypes } from "contracts/types/SystemTypes";
import { config } from "./config";
import { contractComponents, clientComponents } from "./components";
import { world } from "./world";
import { SystemAbis } from "contracts/types/SystemAbis.mjs";
import { EntityID } from "@latticexyz/recs";
import { createFaucetService, SingletonID } from "@latticexyz/network";
import { ethers } from "ethers";
