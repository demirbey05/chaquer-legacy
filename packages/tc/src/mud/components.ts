import {
  defineCoordComponent,
  defineBoolComponent,
} from "@latticexyz/std-client";
import { world } from "./world";
import { defineComponent, Type } from "@latticexyz/recs";

export const components = {
  MapConfig: defineComponent(
    world,
    {
      value: Type.String,
    },
    {
      id: "MapConfig",
      metadata: { contractId: "component.MapConfig" },
    }
  ),
  CastleOwnable: defineComponent(
    world,
    {
      address: Type.String,
    },
    {
      id: "CastleOwnable",
      metadata: { contractId: "component.CastleOwnable" },
    }
  ),
  Position: defineComponent(
    world,
    {
      x: Type.Number,
      y: Type.Number,
    },
    {
      id: "Position",
      metadata: {
        contractId: "component.Position",
      },
    }
  ),
};

export const clientComponents = {};
