-- |
-- Módulo: HERMES (Satélite de Retransmisión)
-- Objetivo: Garantizar que ni un solo bit se pierda en el vacío del espacio.
-- |

import Crypto.Hash.SHA256 (hash)
import Data.ByteString.Char8 (pack)
import Data.ByteString.Base16 (encode)
import Data.Time.Clock (getCurrentTime)

-- Representamos el reporte que nos envía la Voyager IX.
data VoyagerReport = VoyagerReport {
    missionId    :: String, 
    sensorData   :: String, 
    receivedHash :: String  
}


-- si el hash no coincide perfectamente, el mensaje se descarta. 
processHermes :: VoyagerReport -> IO String
processHermes report = do
    -- para comparar lo que llegó contra lo que debería ser.
    let calculatedHash = show $ encode $ hash (pack $ sensorData report)
    
    -- Registramos el momento exacto en que recibimos la señal (timestamp).
    timestamp <- getCurrentTime

    if calculatedHash == receivedHash report
        then return $ "VALIDO|HERMES_ID:001|TS:" ++ show timestamp ++ "|" ++ sensorData report
        
        -- Si hay una sola diferencia, por pequeña que sea, no adivinamos.
        -- Simplemente pedimos que nos lo envíen de nuevo. 
        else return "ERROR: INTEGRIDAD COMPROMETIDA 