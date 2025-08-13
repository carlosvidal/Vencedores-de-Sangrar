#!/bin/bash

# Script para restaurar los capítulos perdidos desde el backup
# y aplicar el nuevo formato con chapter_number separado

# Directorio de backup
BACKUP_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar/backup MD"

# Recorrer todos los archivos de capítulos en el backup
for backup_file in "$BACKUP_DIR/Capítulo "*.md; do
  # Extraer el número y título del capítulo del nombre del archivo
  filename=$(basename "$backup_file")
  chapter_num=$(echo "$filename" | sed -E 's/Capítulo ([0-9]+) - .*/\1/')
  
  # Asegurarse de que el número del capítulo tenga dos dígitos para el directorio
  padded_num=$(printf "%02d" $chapter_num)
  chapter_dir="/Users/carlosvidal/Developer/Vencedores de Sangrar/capitulo-$padded_num"
  
  # Verificar si el directorio existe
  if [ ! -d "$chapter_dir" ]; then
    echo "El directorio $chapter_dir no existe. Omitiendo capítulo $chapter_num."
    continue
  fi
  
  # Leer el contenido del archivo de backup
  content=$(cat "$backup_file")
  
  # Extraer el front matter y el contenido del capítulo
  front_matter=$(echo "$content" | awk '/^---$/{i++} i==1,i==2{print}')
  chapter_content=$(echo "$content" | awk '/^---$/{i++} i==2,EOF{print}' | tail -n +2)
  
  # Extraer el título del front matter
  title=$(echo "$front_matter" | grep 'title:' | sed -E 's/title: "Capítulo [0-9]+: (.*)"$/\1/')
  
  # Crear el nuevo front matter con chapter_number separado
  new_front_matter="---
layout: chapter
chapter_number: $chapter_num
title: \"$title\"
prev_chapter_url: $(echo "$front_matter" | grep 'prev_chapter_url:' | sed 's/prev_chapter_url: //')
prev_chapter_title: $(echo "$front_matter" | grep 'prev_chapter_title:' | sed 's/prev_chapter_title: //')
next_chapter_url: $(echo "$front_matter" | grep 'next_chapter_url:' | sed 's/next_chapter_url: //')
next_chapter_title: $(echo "$front_matter" | grep 'next_chapter_title:' | sed 's/next_chapter_title: //')
---"

  # Crear el nuevo contenido completo
  new_content="$new_front_matter

$chapter_content"

  # Guardar el nuevo contenido en el archivo original
  echo "$new_content" > "$chapter_dir/index.md"
  
  echo "Capítulo $chapter_num restaurado correctamente."
done

echo "¡Restauración completada!"
