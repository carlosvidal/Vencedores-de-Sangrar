#!/bin/bash

# Script final para restaurar todos los capítulos desde el backup
# y aplicar el nuevo formato con chapter_number separado

# Directorio base y de backup
BASE_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar"
BACKUP_DIR="$BASE_DIR/backup MD"

# Crear el directorio del capítulo 33 si no existe
mkdir -p "$BASE_DIR/capitulo-33"

# Obtener la lista de archivos de backup
backup_files=($(find "$BACKUP_DIR" -name "Capítulo*.md" | sort))

# Procesar cada archivo de backup
for backup_file in "${backup_files[@]}"; do
    # Extraer el número del capítulo
    filename=$(basename "$backup_file")
    chapter_num=$(echo "$filename" | grep -o -E '[0-9]+' | head -1)
    
    # Extraer el título del capítulo
    title=$(echo "$filename" | sed -E 's/Capítulo [0-9]+ - (.*).md/\1/')
    
    # Formatear el número del capítulo con ceros a la izquierda
    padded_num=$(printf "%02d" "$chapter_num")
    target_dir="$BASE_DIR/capitulo-$padded_num"
    
    echo "Procesando Capítulo $chapter_num: $title"
    
    # Leer el contenido del archivo de backup
    content=$(cat "$backup_file")
    
    # Extraer el contenido después del front matter
    if grep -q "^---$" "$backup_file"; then
        # Si tiene front matter, extraer el contenido después del segundo ---
        front_matter_count=$(grep -c "^---$" "$backup_file")
        if [ "$front_matter_count" -ge 2 ]; then
            # Hay al menos dos marcadores ---, extraer contenido después del segundo
            chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p==2{print}' "$backup_file")
        else
            # Solo hay un marcador ---, tomar todo después de él
            chapter_content=$(awk 'BEGIN{p=0} /^---$/{p=1; next} p==1{print}' "$backup_file")
        fi
    else
        # Si no tiene front matter, usar todo el contenido
        chapter_content="$content"
    fi
    
    # Determinar capítulos anterior y siguiente
    prev_num=$((chapter_num - 1))
    next_num=$((chapter_num + 1))
    prev_padded_num=$(printf "%02d" "$prev_num")
    next_padded_num=$(printf "%02d" "$next_num")
    
    # Configurar navegación
    if [ "$chapter_num" -eq 1 ]; then
        prev_url="/"
        prev_title="\"Índice\""
    else
        prev_url="/capitulo-$prev_padded_num/"
        
        # Buscar el título del capítulo anterior
        for prev_file in "${backup_files[@]}"; do
            if [[ "$(basename "$prev_file")" =~ Capítulo[[:space:]]*$prev_num ]]; then
                prev_title_text=$(basename "$prev_file" | sed -E 's/Capítulo [0-9]+ - (.*).md/\1/')
                prev_title="\"Capítulo $prev_num: $prev_title_text\""
                break
            fi
        done
        
        # Si no se encontró, usar un título genérico
        if [ -z "$prev_title" ]; then
            prev_title="\"Capítulo $prev_num\""
        fi
    fi
    
    next_url="/capitulo-$next_padded_num/"
    
    # Buscar el título del capítulo siguiente
    next_title=""
    for next_file in "${backup_files[@]}"; do
        if [[ "$(basename "$next_file")" =~ Capítulo[[:space:]]*$next_num ]]; then
            next_title_text=$(basename "$next_file" | sed -E 's/Capítulo [0-9]+ - (.*).md/\1/')
            next_title="\"Capítulo $next_num: $next_title_text\""
            break
        fi
    done
    
    # Si no se encontró, usar un título genérico
    if [ -z "$next_title" ]; then
        next_title="\"Capítulo $next_num\""
    fi
    
    # Crear el nuevo front matter
    new_front_matter="---
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
done

echo "¡Restauración completada!"
