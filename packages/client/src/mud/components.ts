import { defineBoolComponent } from "@latticexyz/std-client";
import { world } from "./world";
import { defineComponent, Type } from "@latticexyz/recs";
import {
  defineStringComponent,
  defineCoordComponent,
} from "@latticexyz/std-client";

export const contractComponents = {
  CastleOwnable: defineStringComponent(world, {
    id: "CastleOwnable",
    metadata: { contractId: "component.CastleOwnable" },
  }),
  MapConfig: defineStringComponent(world, {
    id: "MapConfig",
    metadata: { contractId: "component.MapConfig" },
  }),
  Positiion: defineCoordComponent(world, {
    id: "Position",
    metadata: {
      contractId: "component.Position",
    },
  }),
};

export const clientComponents = {};
