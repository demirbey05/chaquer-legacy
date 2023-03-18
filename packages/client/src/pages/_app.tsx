import "@/styles/globals.css";
import "@/styles/style.css";
import type { AppProps } from "next/app";
import { ChakraProvider } from '@chakra-ui/react'
import { TerrainProvider } from '../context/TerrainContext';

export default function App({ Component, pageProps }: AppProps) {
  return (
    <ChakraProvider>
      <TerrainProvider>
        <Component className="bg-white" {...pageProps} />
      </TerrainProvider> 
    </ChakraProvider>
  )
}
