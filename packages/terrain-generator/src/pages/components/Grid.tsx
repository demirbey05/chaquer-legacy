import { TerrainType, terrainToColor } from "../types";
export type DataProp = {
  width: number;
  height: number;
  values: Array<Array<TerrainType>>;
};
export function Grid(data: DataProp) {
  const width = data.width;
  const height = data.height;
  const values = data.values;
  const rows = Array.from({ length: height }, (v, i) => i);
  const columns = Array.from({ length: width }, (v, i) => i);

  return (
    <div className="inline-grid p-2">
      {rows.map((row) => {
        return columns.map((column) => {
          return (
            <div
              key={`${column},${row}`}
              className={`w-0.5 h-0.5 ${terrainToColor[values[column][row]]}`}
              style={{
                gridColumn: column + 1,
                gridRow: row + 1,
              }}
            ></div>
          );
        });
      })}
    </div>
  );
}
