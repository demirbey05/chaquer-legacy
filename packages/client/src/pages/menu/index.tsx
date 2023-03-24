import { Grid } from "../components/TerrainComp/Grid";
import { generatePerlinValues } from "../../terrain-helper/utils";
import { MouseEvent } from "react";
import MySpinner from "../components/ChakraComp/MySpinner";
import MyModal from "../components/ChakraComp/MyModal";
import { Button } from "@chakra-ui/react";
import Link from "next/link";
import { useTerrain } from "@/context/TerrainContext";
import map from "../../../map.json";
import { useMUD } from "../MudContext";
import { useComponentValue } from "@latticexyz/react";

function Menu() {
  const {
    setIsLoading,
    width,
    height,
    setValues,
    setRefresh,
    refresh,
    isLoading,
    setPermArray,
    saveTerrain,
  } = useTerrain();

  const handleRefresh = (event: MouseEvent<HTMLButtonElement>) => {
    setIsLoading(true);
    event.preventDefault();
    const { valuesArray, perm } = generatePerlinValues(height, width);
    setValues(valuesArray);
    setPermArray(perm);
    setRefresh(() => refresh + 1);
  };

  const handleTerrain = () => {
    saveTerrain();
  };

  const terrainStyles = [8, 7];
  const values = map;
  const { components, systems } = useMUD();

  return (
    <div
      style={{
        backgroundImage: `url('/images/dungeon.png')`,
        backgroundSize: "cover",
        backgroundRepeat: "no-repeat",
      }}
    >
      <div className="container">
        <div className="row align-items-center justify-content-center h-screen items-center">
          {isLoading === true ? (
            <div className="col-8 align-items-center justify-content-center">
              ( <MySpinner></MySpinner> )
            </div>
          ) : (
            <>
              {refresh === 0 ? null : (
                <div className="col-8 align-items-center justify-content-center">
                  <Grid
                    width={width}
                    height={height}
                    values={values}
                    pixelStyles={terrainStyles}
                    isBorder={true}
                  />
                </div>
              )}
            </>
          )}
          <div className="col align-items-center justify-content-center">
            <h2 className="text-center text-white mb-2 display-4 border-top border-bottom font-bold">
              Chaquer
            </h2>
            <img
              className="m-auto mb-5"
              src="/images/castle.png"
              style={{
                width: "250px",
                height: "250px",
                justifyContent: "center",
              }}
            ></img>
            {refresh !== 0 && (
              <div className="text-center mt-2 mb-2">
                <Link href="/game">
                  <Button
                    colorScheme="blackAlpha"
                    border="solid"
                    width="200px"
                    isDisabled={isLoading}
                    textColor="white"
                    variant="ghost"
                    p="7"
                    onClick={handleTerrain}
                  >
                    Start the Game
                  </Button>
                </Link>
              </div>
            )}
            <div className="text-center mb-2">
              <Button
                colorScheme="blackAlpha"
                border="solid"
                width="200px"
                isDisabled={isLoading}
                textColor="white"
                variant="ghost"
                onClick={handleRefresh}
                p="7"
              >
                {refresh === 0 ? "Generate Terrain" : "Regenerate the Terrain"}
              </Button>
            </div>
            {refresh !== 0 && (
              <div className="text-center">
                <MyModal />
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

export default Menu;
