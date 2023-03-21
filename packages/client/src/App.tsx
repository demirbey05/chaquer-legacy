import { useComponentValue } from "@latticexyz/react";
import { useMUD } from "./MUDContext";
import Menu from "./menu"

export const App = () => {
  //const { components, systems, singletonEntity, singletonEntityId } = useMUD();
 
  return (
   <Menu/>
  );
};
