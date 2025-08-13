#!/bin/bash

# Script para restaurar todos los capítulos desde el backup
# y aplicar el nuevo formato con chapter_number separado

# Directorio de backup
BACKUP_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar/backup MD"

# Recorrer todos los archivos de capítulos en el backup
for backup_file in "$BACKUP_DIR/Capítulo "*.md; do
  # Extraer el número del capítulo del nombre del archivo
  filename=$(basename "$backup_file")
  chapter_num=$(echo "$filename" | sed -E 's/Capítulo ([0-9]+).*/\1/')
  
  # Extraer el título del capítulo del nombre del archivo
  title=$(echo "$filename" | sed -E 's/Capítulo [0-9]+ - (.*).md/\1/')
  
  # Asegurarse de que el número del capítulo tenga dos dígitos para el directorio
  padded_num=$(printf "%02d" "$chapter_num")
  chapter_dir="/Users/carlosvidal/Developer/Vencedores de Sangrar/capitulo-$padded_num"
  
  echo "Procesando capítulo $chapter_num: $title (directorio: $chapter_dir)"
  
  # Verificar si el directorio existe
  if [ ! -d "$chapter_dir" ]; then
    echo "El directorio $chapter_dir no existe. Omitiendo capítulo $chapter_num."
    continue
  fi
  
  # Leer el contenido del archivo de backup
  content=$(cat "$backup_file")
  
  # Extraer el contenido después del front matter
  chapter_content=$(echo "$content" | awk 'BEGIN{p=0} /^---$/{p++; if(p==2) next} p==2{print}')
  
  # Si no se encontró el contenido, intentar otro método
  if [ -z "$chapter_content" ]; then
    # Buscar el primer --- y tomar todo lo que sigue
    chapter_content=$(echo "$content" | awk 'BEGIN{p=0} /^---$/{p=1; next} p==1{print}')
  fi
  
  # Determinar las URLs de navegación
  if [ "$chapter_num" -eq 1 ]; then
    prev_url="/"
    prev_title="\"Índice\""
  else
    prev_num=$((chapter_num - 1))
    prev_padded_num=$(printf "%02d" "$prev_num")
    prev_url="/capitulo-$prev_padded_num/"
    
    # Obtener el título del capítulo anterior
    prev_file=$(find "$BACKUP_DIR" -name "Capítulo $prev_num*.md" | head -n 1)
    if [ -n "$prev_file" ]; then
      prev_title_text=$(basename "$prev_file" | sed -E 's/Capítulo [0-9]+ - (.*).md/\1/')
      prev_title="\"Capítulo $prev_num: $prev_title_text\""
    else
      prev_title="\"Capítulo $prev_num: Título anterior\""
    fi
  fi
  
  next_num=$((chapter_num + 1))
  next_padded_num=$(printf "%02d" "$next_num")
  next_url="/capitulo-$next_padded_num/"
  
  # Obtener el título del capítulo siguiente
  next_file=$(find "$BACKUP_DIR" -name "Capítulo $next_num*.md" | head -n 1)
  if [ -n "$next_file" ]; then
    next_title_text=$(basename "$next_file" | sed -E 's/Capítulo [0-9]+ - (.*).md/\1/')
    next_title="\"Capítulo $next_num: $next_title_text\""
  else
    next_title="\"Capítulo $next_num: Título siguiente\""
  fi
  
  # Crear el nuevo front matter
  new_front_matter="---
layout: chapter
chapter_number: $chapter_num
title: \"$title\"
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
done

echo "¡Restauración completada!"
