-- |
-- Módulo: HERMES (Satélite de Retransmisión)
-- Objetivo: Garantizar que ni un solo bit se pierda en el vacío del espacio.
-- |

{-# LANGUAGE OverloadedStrings #-}

import Crypto.Hash.SHA256 (hash)
import Data.ByteString.Char8 (pack)
import Data.ByteString.Base16 (encode)
import Data.Time.Clock (getCurrentTime)
import Control.Monad (forever)
import System.IO (hFlush, stdout)

-- Representamos el reporte que nos envía la Voyager IX.
data VoyagerReport = VoyagerReport {
    missionId    :: String, 
    sensorData   :: String, 
    receivedHash :: String  
} deriving Show

-- Función que procesa el reporte, verificando la integridad
processHermes :: VoyagerReport -> IO String
processHermes report = do
    let calculatedHash = show $ encode $ hash (pack $ sensorData report)
    timestamp <- getCurrentTime

    if calculatedHash == receivedHash report
        then return $ "VALIDO|HERMES_ID:001|TS:" ++ show timestamp ++ "|" ++ sensorData report
        else return "ERROR: INTEGRIDAD COMPROMETIDA"

-- Función para simular la recepción de reportes de Voyager
-- En la demo se puede reemplazar por recepción real de mensajes via TCP/HTTP
receiveVoyagerReports :: IO VoyagerReport
receiveVoyagerReports = do
    putStrLn "Esperando reporte de Voyager IX..."
    hFlush stdout
    -- Simulación de datos de prueba
    let report = VoyagerReport {
        missionId = "VYIX-001",
        sensorData = "DATA: Temperatura 23C, Presion 1013hPa",
        receivedHash = show $ encode $ hash (pack "DATA: Temperatura 23C, Presion 1013hPa")
    }
    return report

-- Loop principal que procesa reportes continuamente
main :: IO ()
main = forever $ do
    report <- receiveVoyagerReports
    result <- processHermes report
    putStrLn result