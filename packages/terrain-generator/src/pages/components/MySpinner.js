import { Spinner, Alert, AlertIcon } from '@chakra-ui/react'

function MySpinner({width}) {
  return (
    <div className="flex flex-col justify-center items-center gap-y-20">
        <Alert width={width} status='info' variant='left-accent'>
        <AlertIcon />
            Please wait few seconds. Map is being generated...
        </Alert>
        <Spinner
            thickness='4px'
            speed='0.65s'
            emptyColor='gray.200'
            color='blue.500'
            size='xl'
        />
    </div>
  )
}

export default MySpinner
