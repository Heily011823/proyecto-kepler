% Base del conocimiento: Formaciones naturales conocidas

formacion_natural(crater).
formacion_natural(volcan).
formacion_natural(montana).
formacion_natural(canon).
formacion_natural(duna).
formacion_natural(glaciar).


% Patrones Geometricos

patron_geometrico(circulo).
patron_geometrico(rectangulo).
patron_geometrico(hexagono).
patron_geometrico(triangulo).


% Datos que son detectados por los sensores (Ejemplos)

% Identificador de la misión
mision(voyager_ix).

% Identificador único de anomalía
anomalia(vx001).
anomalia(vx002).

% Forma geométrica que se detecto
forma(vx001, hexagono).
forma(vx002, crater).

% Nivel de simetría
simetria(vx001, alta).
simetria(vx002, baja).

% Origen conocido
origen_conocido(vx001, no).
origen_conocido(vx002, si).

% Lectura espectral
lectura_espectral(vx001, anomala).
lectura_espectral(vx002, normal).

% Ascensión recta
ascension_recta(vx001, '14h39m').
ascension_recta(vx002, '10h13m').

% Declinación
declinacion(vx001, '-60d50m').
declinacion(vx002, '-20d10m').

% Nivel de confianza
nivel_confianza(vx001, 0.97).
nivel_confianza(vx002, 1.0).

% Timestamp UTC
timestamp(vx001, '2041-05-20T14:33:00Z').
timestamp(vx002, '2041-05-20T16:10:00Z').


% Reglas de inferencia

% Regla 1: Anomalía artificial (Alta simetría, origen desconocido y lectura espectral anómala)

anomalia_artificial(X) :- simetria(X, alta), origen_conocido(X, no), lectura_espectral(X, anomala).


% Regla 2: Anomalía natural (coincidencia con una formación natural y tiene origen conocido)

anomalia_natural(X) :- forma(X, crater), origen_conocido(X, si).


% Clasificación 

clasificar(X, artificial) :- anomalia_artificial(X).

clasificar(X, natural) :- anomalia_natural(X).


% Cadena de Reglas

cadena_de_reglas(X,['simetria_alta', 'origen_desconocido', 'lectura_espectral_anomala']) :- anomalia_artificial(X).


% Reporte 

reporte(X) :- nl, clasificar(X, Resultado), ascension_recta(X, RA), declinacion(X, DEC), 
              lectura_espectral(X, Espectro), nivel_confianza(X, Confianza), 
              timestamp(X, Tiempo), cadena_de_reglas(X, Reglas),


write('Reporte oficial de Voyager IX'),
    nl,

write('========================================'),
    nl,

write('ID de la anomalia: '),
    write(X),
    nl,

    write('Clasificacion: '),
    write(Resultado),
    nl,

    write('Ascension recta: '),
    write(RA),
    nl,

    write('Declinacion: '),
    write(DEC),
    nl,

    write('Lectura espectral: '),
    write(Espectro),
    nl,

    write('Nivel de confianza: '),
    write(Confianza),
    nl,

    write('Timestamp UTC: '),
    write(Tiempo),
    nl,

    write('Cadena de reglas: '),
    write(Reglas),
    nl.   