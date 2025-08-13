#!/bin/bash

# Script simple y directo para restaurar todos los capítulos desde el 4 en adelante
# con el nuevo formato de front matter que separa chapter_number del título

BASE_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar"
BACKUP_DIR="$BASE_DIR/backup MD"

# Asegurarse de que existe el directorio del capítulo 33
mkdir -p "$BASE_DIR/capitulo-33"

# Función para restaurar un capítulo específico
restore_chapter() {
    local chapter_num=$1
    local padded_num=$(printf "%02d" $chapter_num)
    local chapter_dir="$BASE_DIR/capitulo-$padded_num"
    
    # Nombre exacto del archivo de backup
    local backup_file="$BACKUP_DIR/Capítulo $chapter_num - "
    
    # Buscar el archivo que comienza con ese patrón
    local full_backup_file=$(find "$BACKUP_DIR" -name "Capítulo $chapter_num -*" -type f | head -n 1)
    
    if [ -z "$full_backup_file" ]; then
        echo "No se encontró archivo de backup para el capítulo $chapter_num"
        return 1
    fi
    
    echo "Restaurando capítulo $chapter_num desde $full_backup_file"
    
    # Extraer el título del nombre del archivo
    local filename=$(basename "$full_backup_file")
    local title=$(echo "$filename" | sed -E "s/Capítulo $chapter_num - (.*).md/\1/")
    
    # Determinar capítulos anterior y siguiente
    local prev_num=$((chapter_num - 1))
    local next_num=$((chapter_num + 1))
    local prev_padded_num=$(printf "%02d" $prev_num)
    local next_padded_num=$(printf "%02d" $next_num)
    
    # Configurar navegación
    local prev_url prev_title next_url next_title
    
    if [ "$chapter_num" -eq 1 ]; then
        prev_url="/"
        prev_title="\"Índice\""
    else
        prev_url="/capitulo-$prev_padded_num/"
        
        # Buscar el título del capítulo anterior
        local prev_file=$(find "$BACKUP_DIR" -name "Capítulo $prev_num -*" -type f | head -n 1)
        if [ -n "$prev_file" ]; then
            local prev_title_text=$(basename "$prev_file" | sed -E "s/Capítulo $prev_num - (.*).md/\1/")
            prev_title="\"Capítulo $prev_num: $prev_title_text\""
        else
            prev_title="\"Capítulo $prev_num\""
        fi
    fi
    
    next_url="/capitulo-$next_padded_num/"
    
    # Buscar el título del capítulo siguiente
    local next_file=$(find "$BACKUP_DIR" -name "Capítulo $next_num -*" -type f | head -n 1)
    if [ -n "$next_file" ]; then
        local next_title_text=$(basename "$next_file" | sed -E "s/Capítulo $next_num - (.*).md/\1/")
        next_title="\"Capítulo $next_num: $next_title_text\""
    else
        next_title="\"Capítulo $next_num\""
    fi
    
    # Leer el contenido del archivo de backup
    local content=$(cat "$full_backup_file")
    
    # Extraer el contenido después del front matter
    local chapter_content=""
    if grep -q "^---$" "$full_backup_file"; then
        # Contar cuántos separadores --- hay
        local separator_count=$(grep -c "^---$" "$full_backup_file")
        
        if [ "$separator_count" -ge 2 ]; then
            # Hay al menos dos marcadores ---, extraer contenido después del segundo
            chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p>=2{print}' "$full_backup_file")
        else
            # Solo hay un marcador ---, tomar todo después de él
            chapter_content=$(awk 'BEGIN{p=0} /^---$/{p=1; next} p>=1{print}' "$full_backup_file")
        fi
    else
        # Si no tiene front matter, usar todo el contenido
        chapter_content="$content"
    fi
    
    # Si no se pudo extraer el contenido, intentar otro método
    if [ -z "$chapter_content" ]; then
        # Buscar el primer --- y tomar todo lo que sigue
        chapter_content=$(sed -n '/^---$/,$p' "$full_backup_file" | sed '1d')
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
    echo "$new_front_matter" > "$chapter_dir/index.md"
    echo "" >> "$chapter_dir/index.md"
    echo "$chapter_content" >> "$chapter_dir/index.md"
    
    echo "Capítulo $chapter_num restaurado correctamente."
}

# Restaurar capítulos del 4 al 40
for i in {4..40}; do
    restore_chapter $i
done

echo "¡Restauración completada!"
