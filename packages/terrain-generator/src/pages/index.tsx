import Head from "next/head";
import Image from "next/image";
import { Inter } from "@next/font/google";
import styles from "@/styles/Home.module.css";
import { Grid, DataProp } from "./components/Grid";
import { TerrainType } from "./types";
import { generateValues, generatePerlinValues } from "./utils";
import { useState, useEffect } from "react";
import MySpinner from './components/MySpinner';


const inter = Inter({ subsets: ["latin"] });

export default function Home() {
  const width = 300;
  const height = 300;
  const [values, setValues] = useState<TerrainType[][]>([]);
  const [refresh, setRefresh] = useState<number>(0);
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const handleRefresh = (event: React.MouseEvent<HTMLButtonElement>) => {
    setIsLoading(true);
    event.preventDefault();
    const values = generatePerlinValues(height, width);
    setValues(values);
    setRefresh(() => refresh + 1);
    console.log(refresh);
  };

  useEffect(() => {
    setIsLoading(false);
  },[values])

  return (
    <>
      <div className="flex flex-col justify-center items-center gap-y-20">
        <h1 className="text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">
          XWar Game Generator
        </h1>
        {
          isLoading === true ? 
          ( <MySpinner width={width}></MySpinner> ): 
          <div>
          {refresh === 0 ? null : (
            <Grid width={width} height={height} values={values} />
          )}
        </div>
        }
        <div className="flex flex-row">
          <button className="text-white bg-gray-800 hover:bg-gray-900 focus:outline-none focus:ring-4 focus:ring-gray-300 font-medium rounded-full text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-gray-800 dark:hover:bg-gray-700 dark:focus:ring-gray-700 dark:border-gray-700">
            Go
          </button>
          <button
            className="text-white bg-gray-800 hover:bg-gray-900 focus:outline-none focus:ring-4 focus:ring-gray-300 font-medium rounded-full text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-gray-800 dark:hover:bg-gray-700 dark:focus:ring-gray-700 dark:border-gray-700"
            onClick={handleRefresh}
          >
            {refresh === 0 ? "Generate" : "Refresh the Map"}
          </button>
        </div>
      </div>
    </>
  );
}
