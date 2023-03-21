import "tailwindcss/tailwind.css";
import "react-toastify/dist/ReactToastify.css";
import ReactDOM from "react-dom/client";
import { ToastContainer } from "react-toastify";
import { App } from "./App";
import { setup } from "./mud/setup";
import { MUDProvider } from "./MUDContext";
import { ComponentBrowser } from "./ComponentBrowser";
import { ChakraProvider } from '@chakra-ui/react'
import {TerrainProvider} from "./context/TerrainContext.js";


const rootElement = document.getElementById("react-root");
if (!rootElement) throw new Error("React root not found");
const root = ReactDOM.createRoot(rootElement);

// TODO: figure out if we actually want this to be async or if we should render something else in the meantime
setup().then((result) => {
  root.render(
    <ChakraProvider>
    <MUDProvider {...result}>
      <TerrainProvider>
      <App />
      </TerrainProvider>
    </MUDProvider>
    </ChakraProvider>
  );
});
