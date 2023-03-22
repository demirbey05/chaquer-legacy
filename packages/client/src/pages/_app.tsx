import "@/styles/globals.css";
import "@/styles/style.css";
import type { AppProps } from "next/app";
import { ChakraProvider } from "@chakra-ui/react";
import { TerrainProvider } from "../context/TerrainContext";
import { MUDProvider } from "./MudContext";
import { useEffect, useState } from "react";
import { setup } from "../mud/setup";

export default function App({ Component, pageProps }: AppProps) {
  const [result, setResult] = useState<any>();

  useEffect(() => {
    setup().then((res) => {
      setResult(res);
    });
  }, []);

  return (
    <ChakraProvider>
      <MUDProvider {...result}>
        <TerrainProvider>
          <Component className="bg-white" {...pageProps} />
        </TerrainProvider>
      </MUDProvider>
    </ChakraProvider>
  );
}
