import { Grid } from "../components/TerrainComp/Grid";
import { useTerrain } from "@/context/TerrainContext";
import map from '../../../map.json';
import { ScrollContainer } from 'react-indiana-drag-scroll';
import 'react-indiana-drag-scroll/dist/style.css'

function Game() {
    const { width, height } = useTerrain();
    const values = map;

    const terrainStyles = [ 0, 25 ];
    const smallMap = [1,2];

    const handleMouseMove = (event) => {
      console.log(`Mouse konumu: x=${event.clientX}, y=${event.clientY}`);
    }

    return (
      <div>
        <div style={{position:"fixed", zIndex:"1", bottom:"0", left:"0", marginLeft:"2px",marginBottom:"2px"}}>
          <Grid width={width} height={height} values={values} pixelStyles={smallMap} isBorder={true}/>
        </div>
        <div>
          <ScrollContainer onMouseMove={handleMouseMove} activationDistance={"1px"} vertical={true} horizontal={true} className="scroll-container" style={{ zIndex:"0", cursor:"default", height:"100vh"}} tabIndex="0">
            <Grid width={width} height={height} values={values} pixelStyles={terrainStyles}/>
          </ScrollContainer>
        </div>
      </div>
    )
}

export default Game