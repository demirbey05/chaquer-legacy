import Head from "next/head";
import Image from "next/image";
import { Inter } from "@next/font/google";
import styles from "@/styles/Home.module.css";
import { Grid, DataProp } from "./components/Grid";
import { TerrainType } from "./types";
import { generateValues, generatePerlinValues } from "./utils";
import { useState, useEffect } from "react";

const inter = Inter({ subsets: ["latin"] });

export default function Home() {
  const width = 300;
  const height = 300;
  const [values, setValues] = useState<TerrainType[][]>(
    generatePerlinValues(height, width)
  );
  const [refresh, setRefresh] = useState<number>(0);
  /*useEffect(() => {
    const terrain = generateValues(height, width);
    console.log(terrain);
    setValues(terrain);
  }, []);*/
  console.log(values);

  return (
    <>
      <div className="flex flex-col justify-center items-center gap-y-20">
        <h1 className="text-4xl font-extrabold leading-none tracking-tight text-gray-900 md:text-5xl lg:text-6xl dark:text-white">
          XWar Game Generator
        </h1>
        <div>
          <Grid width={width} height={height} values={values} />
        </div>
        <div></div>
      </div>
    </>
  );
}
