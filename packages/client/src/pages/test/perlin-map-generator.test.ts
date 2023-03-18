import { generatePerlinValues } from "../../terrain-helper/utils";

describe("Terrain Generation with Perlin Noise", () => {
  test("it should give the histogram", () => {
    const intervals = generatePerlinValues(300, 300);
    console.log(intervals);
  });
});
