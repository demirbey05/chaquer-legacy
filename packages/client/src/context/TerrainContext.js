import {useState, useEffect, useContext, createContext} from 'react';

const TerrainContext = createContext();

const TerrainProvider = ({children}) => {
    const width = 100;
    const height = 100;
    const [values, setValues] = useState(null);
    const [permArray, setPermArray] = useState(null);
    const [refresh, setRefresh] = useState(0);
    const [isLoading, setIsLoading] = useState(false);

    useEffect(() => {
        saveTerrain();
        setIsLoading(false);
    },[values])

    useEffect(() => {
        const terrain = window.localStorage.getItem('terrain');
        setValues(JSON.parse(terrain));
        console.log(values);
    },[]);

    const saveTerrain = () => {
        window.localStorage.setItem('terrain', JSON.stringify(values));
    }

    const results = {
        values,
        setIsLoading,
        width,
        height,
        setValues,
        setRefresh,
        refresh,
        isLoading,
        setPermArray,
        saveTerrain
    }

    return <TerrainContext.Provider value={results}>{children}</TerrainContext.Provider>
}

const useTerrain = () => useContext(TerrainContext);

export { TerrainProvider, useTerrain};
