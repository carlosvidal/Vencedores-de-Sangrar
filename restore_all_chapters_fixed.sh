#!/bin/bash

# Script para restaurar todos los capítulos desde el backup
# y aplicar el nuevo formato con chapter_number separado

# Directorio base y de backup
BASE_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar"
BACKUP_DIR="$BASE_DIR/backup MD"

# Crear el directorio del capítulo 33 si no existe
mkdir -p "$BASE_DIR/capitulo-33"

# Función para extraer el número y título de un capítulo
process_chapter() {
    local backup_file="$1"
    local chapter_num=$(echo "$backup_file" | grep -oE 'Capítulo ([0-9]+)' | grep -oE '[0-9]+')
    local title=$(echo "$backup_file" | sed -E 's/.*Capítulo [0-9]+ - (.*).md/\1/')
    local padded_num=$(printf "%02d" "$chapter_num")
    local target_dir="$BASE_DIR/capitulo-$padded_num"
    
    echo "Procesando Capítulo $chapter_num: $title"
    
    # Leer el contenido del archivo de backup
    local content=$(cat "$backup_file")
    
    # Extraer el contenido después del front matter
    local chapter_content=""
    if grep -q "^---$" "$backup_file"; then
        # Si tiene front matter, extraer el contenido después del segundo ---
        chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p>=1{print}' "$backup_file" | awk 'NR>1{print}')
    else
        # Si no tiene front matter, usar todo el contenido
        chapter_content="$content"
    fi
    
    # Determinar capítulos anterior y siguiente
    local prev_num=$((chapter_num - 1))
    local next_num=$((chapter_num + 1))
    local prev_padded_num=$(printf "%02d" "$prev_num")
    local next_padded_num=$(printf "%02d" "$next_num")
    
    # Configurar navegación
    local prev_url prev_title next_url next_title
    
    if [ "$chapter_num" -eq 1 ]; then
        prev_url="/"
        prev_title="\"Índice\""
    else
        prev_url="/capitulo-$prev_padded_num/"
        
        # Buscar el título del capítulo anterior
        local prev_file=$(find "$BACKUP_DIR" -name "Capítulo $prev_num*.md" | head -n 1)
        if [ -n "$prev_file" ]; then
            local prev_title_text=$(basename "$prev_file" | sed -E 's/.*Capítulo [0-9]+ - (.*).md/\1/')
            prev_title="\"Capítulo $prev_num: $prev_title_text\""
        else
            prev_title="\"Capítulo $prev_num\""
        fi
    fi
    
    next_url="/capitulo-$next_padded_num/"
    
    # Buscar el título del capítulo siguiente
    local next_file=$(find "$BACKUP_DIR" -name "Capítulo $next_num*.md" | head -n 1)
    if [ -n "$next_file" ]; then
        local next_title_text=$(basename "$next_file" | sed -E 's/.*Capítulo [0-9]+ - (.*).md/\1/')
        next_title="\"Capítulo $next_num: $next_title_text\""
    else
        next_title="\"Capítulo $next_num\""
    fi
    
    # Crear el nuevo front matter
    local new_front_matter="---
layout: chapter
chapter_number: $chapter_num
title: \"$title\"
permalink: /capitulo-$padded_num/
prev_chapter_url: $prev_url
prev_chapter_title: $prev_title
next_chapter_url: $next_url
next_chapter_title: $next_title
---"

    # Guardar el nuevo contenido en el archivo original
    echo "$new_front_matter" > "$target_dir/index.md"
    echo "" >> "$target_dir/index.md"
    echo "$chapter_content" >> "$target_dir/index.md"
    
    echo "Capítulo $chapter_num restaurado correctamente."
}

# Procesar todos los archivos de capítulos en el backup
for backup_file in "$BACKUP_DIR"/Capítulo*.md; do
    process_chapter "$backup_file"
done

echo "¡Restauración completada!"
