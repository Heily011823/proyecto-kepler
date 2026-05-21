package com.kepler.atlas; 

import java.time.Instant;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.io.IOException;

/**
 * Nodo ATLAS: Estación de Coordinación de Misiones Profundas.
 * Representa el nodo central operado por 16 agencias espaciales
 */
public class Main {
    
    // ATLAS gestiona 140 misiones simultáneas según el protocolo
    private static final int ACTIVE_MISSIONS = 140;
    private static final String AGENCY = "Consorcio Espacial";

    public static void main(String[] args) {
      
        String rutaHermes = "../../shared/contracts/hermes_packet.json";

        try {
          
            String content = Files.readString(Paths.get(rutaHermes));
            
        
            String enrichedData = enrichForGround(content);
            
            System.out.println("--- ATLAS: Transmisión Procesada ---");
            System.out.println(enrichedData);

        } catch (IOException e) {
            
            System.err.println("CRÍTICO: No se encontró el contrato de HERMES en: " + rutaHermes);
        }
    }

    public static String enrichForGround(String incomingData) {
        // Construimos el JSON enriquecido para GROUND [cite: 22, 25]
        return "{\n" +
            "  \"prioridad\": \"MÁXIMA\",\n" + // Alerta nivel máximo según enunciado [cite: 21]
            "  \"agencia\": \"" + AGENCY + "\",\n" +
            "  \"misiones_activas\": " + ACTIVE_MISSIONS + ",\n" +
            "  \"trazabilidad\": \"VOYAGER-IX -> HERMES -> ATLAS\",\n" + // Trazabilidad reconstruible 
            "  \"payload\": " + incomingData + ",\n" +
            "  \"timestamp_atlas\": \"" + Instant.now() + "\"\n" +
            "}";
    }
}