#!/bin/bash

# Script final para migrar capítulos a estructura de carpetas para permalinks
# Este script procesa cada archivo individualmente

# Directorio base
BASE_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar"

# Crear directorios para cada capítulo y copiar los archivos
mkdir -p "$BASE_DIR/capitulo-01"
cp "$BASE_DIR/Capítulo 01 - La última partida de Vargas.md" "$BASE_DIR/capitulo-01/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-01/index.md"
echo "Procesado: Capítulo 01"

mkdir -p "$BASE_DIR/capitulo-02"
cp "$BASE_DIR/Capítulo 02 - La carretera envuelta en niebla.md" "$BASE_DIR/capitulo-02/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-02/index.md"
echo "Procesado: Capítulo 02"

mkdir -p "$BASE_DIR/capitulo-03"
cp "$BASE_DIR/Capítulo 03 - Voces de la sierra.md" "$BASE_DIR/capitulo-03/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-03/index.md"
echo "Procesado: Capítulo 03"

mkdir -p "$BASE_DIR/capitulo-04"
cp "$BASE_DIR/Capítulo 04 - La orden.md" "$BASE_DIR/capitulo-04/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-04/index.md"
echo "Procesado: Capítulo 04"

mkdir -p "$BASE_DIR/capitulo-05"
cp "$BASE_DIR/Capítulo 05 - El viaje fatídico.md" "$BASE_DIR/capitulo-05/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-05/index.md"
echo "Procesado: Capítulo 05"

mkdir -p "$BASE_DIR/capitulo-06"
cp "$BASE_DIR/Capítulo 06 - Primeras sospechas.md" "$BASE_DIR/capitulo-06/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-06/index.md"
echo "Procesado: Capítulo 06"

mkdir -p "$BASE_DIR/capitulo-07"
cp "$BASE_DIR/Capítulo 07 - El camino de Montenegro.md" "$BASE_DIR/capitulo-07/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-07/index.md"
echo "Procesado: Capítulo 07"

mkdir -p "$BASE_DIR/capitulo-08"
cp "$BASE_DIR/Capítulo 08 - Sombras en la noche.md" "$BASE_DIR/capitulo-08/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-08/index.md"
echo "Procesado: Capítulo 08"

mkdir -p "$BASE_DIR/capitulo-09"
cp "$BASE_DIR/Capítulo 09 - La noche en el Rancho Rosa.md" "$BASE_DIR/capitulo-09/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-09/index.md"
echo "Procesado: Capítulo 09"

mkdir -p "$BASE_DIR/capitulo-10"
cp "$BASE_DIR/Capítulo 10 - Madrugada en Huayre.md" "$BASE_DIR/capitulo-10/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-10/index.md"
echo "Procesado: Capítulo 10"

mkdir -p "$BASE_DIR/capitulo-11"
cp "$BASE_DIR/Capítulo 11 - El amanecer en el bosque de piedras.md" "$BASE_DIR/capitulo-11/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-11/index.md"
echo "Procesado: Capítulo 11"

mkdir -p "$BASE_DIR/capitulo-12"
cp "$BASE_DIR/Capítulo 12 - Decisión en la puna.md" "$BASE_DIR/capitulo-12/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-12/index.md"
echo "Procesado: Capítulo 12"

mkdir -p "$BASE_DIR/capitulo-13"
cp "$BASE_DIR/Capítulo 13 - Llamada desde la selva.md" "$BASE_DIR/capitulo-13/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-13/index.md"
echo "Procesado: Capítulo 13"

mkdir -p "$BASE_DIR/capitulo-14"
cp "$BASE_DIR/Capítulo 14 - La entrevista en la mina.md" "$BASE_DIR/capitulo-14/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-14/index.md"
echo "Procesado: Capítulo 14"

mkdir -p "$BASE_DIR/capitulo-15"
cp "$BASE_DIR/Capítulo 15 - El orador del pueblo.md" "$BASE_DIR/capitulo-15/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-15/index.md"
echo "Procesado: Capítulo 15"

mkdir -p "$BASE_DIR/capitulo-16"
cp "$BASE_DIR/Capítulo 16 - Aguas turbias.md" "$BASE_DIR/capitulo-16/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-16/index.md"
echo "Procesado: Capítulo 16"

mkdir -p "$BASE_DIR/capitulo-17"
cp "$BASE_DIR/Capítulo 17 - El caso cerrado.md" "$BASE_DIR/capitulo-17/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-17/index.md"
echo "Procesado: Capítulo 17"

mkdir -p "$BASE_DIR/capitulo-18"
cp "$BASE_DIR/Capítulo 18 - El camino a Huancayo.md" "$BASE_DIR/capitulo-18/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-18/index.md"
echo "Procesado: Capítulo 18"

mkdir -p "$BASE_DIR/capitulo-19"
cp "$BASE_DIR/Capítulo 19 - Nueva ciudad, viejas pesadillas.md" "$BASE_DIR/capitulo-19/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-19/index.md"
echo "Procesado: Capítulo 19"

mkdir -p "$BASE_DIR/capitulo-20"
cp "$BASE_DIR/Capítulo 20 - El precio de la curiosidad.md" "$BASE_DIR/capitulo-20/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-20/index.md"
echo "Procesado: Capítulo 20"

mkdir -p "$BASE_DIR/capitulo-21"
cp "$BASE_DIR/Capítulo 21 - El eco de un disparo.md" "$BASE_DIR/capitulo-21/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-21/index.md"
echo "Procesado: Capítulo 21"

mkdir -p "$BASE_DIR/capitulo-22"
cp "$BASE_DIR/Capítulo 22 - Secretos Enterrados.md" "$BASE_DIR/capitulo-22/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-22/index.md"
echo "Procesado: Capítulo 22"

mkdir -p "$BASE_DIR/capitulo-23"
cp "$BASE_DIR/Capítulo 23 - Estrellas de neón.md" "$BASE_DIR/capitulo-23/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-23/index.md"
echo "Procesado: Capítulo 23"

mkdir -p "$BASE_DIR/capitulo-24"
cp "$BASE_DIR/Capítulo 24 - Luces, cámaras, verdad.md" "$BASE_DIR/capitulo-24/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-24/index.md"
echo "Procesado: Capítulo 24"

mkdir -p "$BASE_DIR/capitulo-25"
cp "$BASE_DIR/Capítulo 25 - Un intruso en la habitación.md" "$BASE_DIR/capitulo-25/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-25/index.md"
echo "Procesado: Capítulo 25"

mkdir -p "$BASE_DIR/capitulo-26"
cp "$BASE_DIR/Capítulo 26 - Conexiones peligrosas.md" "$BASE_DIR/capitulo-26/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-26/index.md"
echo "Procesado: Capítulo 26"

mkdir -p "$BASE_DIR/capitulo-27"
cp "$BASE_DIR/Capítulo 27 - Bloqueo en la carretera.md" "$BASE_DIR/capitulo-27/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-27/index.md"
echo "Procesado: Capítulo 27"

mkdir -p "$BASE_DIR/capitulo-28"
cp "$BASE_DIR/Capítulo 28 - Sangre en el asfalto.md" "$BASE_DIR/capitulo-28/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-28/index.md"
echo "Procesado: Capítulo 28"

mkdir -p "$BASE_DIR/capitulo-29"
cp "$BASE_DIR/Capítulo 29 - Fuego cruzado.md" "$BASE_DIR/capitulo-29/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-29/index.md"
echo "Procesado: Capítulo 29"

mkdir -p "$BASE_DIR/capitulo-30"
cp "$BASE_DIR/Capítulo 30 - La casa del poder.md" "$BASE_DIR/capitulo-30/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-30/index.md"
echo "Procesado: Capítulo 30"

mkdir -p "$BASE_DIR/capitulo-31"
cp "$BASE_DIR/Capítulo 31 - Encuentro en Lima.md" "$BASE_DIR/capitulo-31/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-31/index.md"
echo "Procesado: Capítulo 31"

mkdir -p "$BASE_DIR/capitulo-32"
cp "$BASE_DIR/Capítulo 32 - Lugar de la memoria.md" "$BASE_DIR/capitulo-32/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-32/index.md"
echo "Procesado: Capítulo 32"

mkdir -p "$BASE_DIR/capitulo-34"
cp "$BASE_DIR/Capítulo 34 - La sombra del sicario.md" "$BASE_DIR/capitulo-34/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-34/index.md"
echo "Procesado: Capítulo 34"

mkdir -p "$BASE_DIR/capitulo-35"
cp "$BASE_DIR/Capítulo 35 - Pactos oscuros.md" "$BASE_DIR/capitulo-35/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-35/index.md"
echo "Procesado: Capítulo 35"

mkdir -p "$BASE_DIR/capitulo-36"
cp "$BASE_DIR/Capítulo 36 - Tras las huellas del sicario.md" "$BASE_DIR/capitulo-36/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-36/index.md"
echo "Procesado: Capítulo 36"

mkdir -p "$BASE_DIR/capitulo-37"
cp "$BASE_DIR/Capítulo 37 - El interrogatorio.md" "$BASE_DIR/capitulo-37/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-37/index.md"
echo "Procesado: Capítulo 37"

mkdir -p "$BASE_DIR/capitulo-38"
cp "$BASE_DIR/Capítulo 38 - Revelaciones en Sángrar.md" "$BASE_DIR/capitulo-38/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-38/index.md"
echo "Procesado: Capítulo 38"

mkdir -p "$BASE_DIR/capitulo-39"
cp "$BASE_DIR/Capítulo 39 - El peso de la verdad.md" "$BASE_DIR/capitulo-39/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-39/index.md"
echo "Procesado: Capítulo 39"

mkdir -p "$BASE_DIR/capitulo-40"
cp "$BASE_DIR/Capítulo 40 - Domingo al día.md" "$BASE_DIR/capitulo-40/index.md"
sed -i '' '/permalink:/d' "$BASE_DIR/capitulo-40/index.md"
echo "Procesado: Capítulo 40"

echo "Migración completada. Todos los capítulos han sido convertidos a estructura de carpetas."
