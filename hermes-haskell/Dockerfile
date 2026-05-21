FROM haskell:9.2
WORKDIR /app

# Copiar código
COPY ./src ./src

# Instalar librerías necesarias para GHC
RUN cabal update && \
    cabal install --lib cryptohash base16-bytestring bytestring time

# Compilar el binario
RUN ghc -o hermes src/Main.hs

# Comando por defecto
CMD ["./hermes"]