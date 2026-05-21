FROM haskell:9.2
WORKDIR /app

# Copiar el código fuente
COPY ./src ./src

# Compilar el binario
RUN ghc -o hermes src/Main.hs

# Comando por defecto
CMD ["./hermes"]