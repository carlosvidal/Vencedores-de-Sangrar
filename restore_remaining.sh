#!/bin/bash

# Script para restaurar los capítulos restantes (11-40)
# con el nuevo formato de front matter que separa chapter_number del título

BASE_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar"
BACKUP_DIR="$BASE_DIR/backup MD"

# Función para restaurar un capítulo específico
restore_chapter() {
    local chapter_num=$1
    local padded_num=$(printf "%02d" $chapter_num)
    local chapter_dir="$BASE_DIR/capitulo-$padded_num"
    local title=$2
    local prev_num=$((chapter_num - 1))
    local next_num=$((chapter_num + 1))
    local prev_padded_num=$(printf "%02d" $prev_num)
    local next_padded_num=$(printf "%02d" $next_num)
    local prev_title=$3
    local next_title=$4
    local backup_file="$BACKUP_DIR/Capítulo $chapter_num - $title.md"
    
    echo "Restaurando capítulo $chapter_num: $title"
    
    # Crear el directorio del capítulo
    mkdir -p "$chapter_dir"
    
    # Extraer el contenido después del front matter
    local chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p==2{print}' "$backup_file")
    
    # Si no se pudo extraer el contenido, intentar otro método
    if [ -z "$chapter_content" ]; then
        chapter_content=$(awk 'BEGIN{p=0} /^---$/{p=1; next} p==1{print}' "$backup_file")
    fi
    
    # Crear el nuevo front matter
    cat > "$chapter_dir/index.md" << EOF
---
layout: chapter
chapter_number: $chapter_num
title: "$title"
permalink: /capitulo-$padded_num/
prev_chapter_url: /capitulo-$prev_padded_num/
prev_chapter_title: "Capítulo $prev_num: $prev_title"
next_chapter_url: /capitulo-$next_padded_num/
next_chapter_title: "Capítulo $next_num: $next_title"
---

$chapter_content
EOF
    
    echo "Capítulo $chapter_num restaurado correctamente."
}

# Restaurar capítulo 11
restore_chapter 11 "El amanecer en el bosque de piedras" "Madrugada en Huayre" "Decisión en la puna"

# Restaurar capítulo 12
restore_chapter 12 "Decisión en la puna" "El amanecer en el bosque de piedras" "Llamada desde la selva"

# Restaurar capítulo 13
restore_chapter 13 "Llamada desde la selva" "Decisión en la puna" "La entrevista en la mina"

# Restaurar capítulo 14
restore_chapter 14 "La entrevista en la mina" "Llamada desde la selva" "El orador del pueblo"

# Restaurar capítulo 15
restore_chapter 15 "El orador del pueblo" "La entrevista en la mina" "Aguas turbias"

# Restaurar capítulo 16
restore_chapter 16 "Aguas turbias" "El orador del pueblo" "El caso cerrado"

# Restaurar capítulo 17
restore_chapter 17 "El caso cerrado" "Aguas turbias" "El camino a Huancayo"

# Restaurar capítulo 18
restore_chapter 18 "El camino a Huancayo" "El caso cerrado" "Nueva ciudad, viejas pesadillas"

# Restaurar capítulo 19
restore_chapter 19 "Nueva ciudad, viejas pesadillas" "El camino a Huancayo" "El precio de la curiosidad"

# Restaurar capítulo 20
restore_chapter 20 "El precio de la curiosidad" "Nueva ciudad, viejas pesadillas" "El eco de un disparo"

# Restaurar capítulo 21
restore_chapter 21 "El eco de un disparo" "El precio de la curiosidad" "Secretos Enterrados"

# Restaurar capítulo 22
restore_chapter 22 "Secretos Enterrados" "El eco de un disparo" "Estrellas de neón"

# Restaurar capítulo 23
restore_chapter 23 "Estrellas de neón" "Secretos Enterrados" "Luces, cámaras, verdad"

# Restaurar capítulo 24
restore_chapter 24 "Luces, cámaras, verdad" "Estrellas de neón" "Un intruso en la habitación"

# Restaurar capítulo 25
restore_chapter 25 "Un intruso en la habitación" "Luces, cámaras, verdad" "Conexiones peligrosas"

# Restaurar capítulo 26
restore_chapter 26 "Conexiones peligrosas" "Un intruso en la habitación" "Bloqueo en la carretera"

# Restaurar capítulo 27
restore_chapter 27 "Bloqueo en la carretera" "Conexiones peligrosas" "Sangre en el asfalto"

# Restaurar capítulo 28
restore_chapter 28 "Sangre en el asfalto" "Bloqueo en la carretera" "Fuego cruzado"

# Restaurar capítulo 29
restore_chapter 29 "Fuego cruzado" "Sangre en el asfalto" "La casa del poder"

# Restaurar capítulo 30
restore_chapter 30 "La casa del poder" "Fuego cruzado" "Encuentro en Lima"

# Restaurar capítulo 31
restore_chapter 31 "Encuentro en Lima" "La casa del poder" "Lugar de la memoria"

# Restaurar capítulo 32
restore_chapter 32 "Lugar de la memoria" "Encuentro en Lima" "La caja de Pandora"

# Restaurar capítulo 33
restore_chapter 33 "La caja de Pandora" "Lugar de la memoria" "La sombra del sicario"

# Restaurar capítulo 34
restore_chapter 34 "La sombra del sicario" "La caja de Pandora" "Pactos oscuros"

# Restaurar capítulo 35
restore_chapter 35 "Pactos oscuros" "La sombra del sicario" "Tras las huellas del sicario"

# Restaurar capítulo 36
restore_chapter 36 "Tras las huellas del sicario" "Pactos oscuros" "El interrogatorio"

# Restaurar capítulo 37
restore_chapter 37 "El interrogatorio" "Tras las huellas del sicario" "Revelaciones en Sángrar"

# Restaurar capítulo 38
restore_chapter 38 "Revelaciones en Sángrar" "El interrogatorio" "El peso de la verdad"

# Restaurar capítulo 39
restore_chapter 39 "El peso de la verdad" "Revelaciones en Sángrar" "Domingo al día"

# Restaurar capítulo 40
restore_chapter 40 "Domingo al día" "El peso de la verdad" "Epílogo"

echo "¡Restauración completada para los capítulos 11-40!"
