#!/bin/bash

# Script mejorado para restaurar los capítulos perdidos desde el backup
# y aplicar el nuevo formato con chapter_number separado

# Directorio de backup
BACKUP_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar/backup MD"

# Recorrer todos los archivos de capítulos en el backup
find "$BACKUP_DIR" -name "Capítulo [0-9]*.md" | sort | while read backup_file; do
  # Extraer el número del capítulo del nombre del archivo
  filename=$(basename "$backup_file")
  chapter_num=$(echo "$filename" | sed -E 's/Capítulo ([0-9]+).*/\1/')
  
  # Asegurarse de que el número del capítulo tenga dos dígitos para el directorio
  padded_num=$(printf "%02d" "$chapter_num")
  chapter_dir="/Users/carlosvidal/Developer/Vencedores de Sangrar/capitulo-$padded_num"
  
  echo "Procesando capítulo $chapter_num (directorio: $chapter_dir)"
  
  # Verificar si el directorio existe
  if [ ! -d "$chapter_dir" ]; then
    echo "El directorio $chapter_dir no existe. Omitiendo capítulo $chapter_num."
    continue
  fi
  
  # Leer el contenido del archivo de backup
  content=$(cat "$backup_file")
  
  # Extraer el título del front matter
  title=$(echo "$content" | grep -E 'title: "Capítulo [0-9]+: ' | sed -E 's/title: "Capítulo [0-9]+: (.*)"$/\1/')
  
  if [ -z "$title" ]; then
    echo "No se pudo extraer el título del capítulo $chapter_num. Intentando otro método..."
    # Intentar extraer del nombre del archivo
    title=$(echo "$filename" | sed -E 's/Capítulo [0-9]+ - (.*).md/\1/')
    if [ -z "$title" ]; then
      echo "No se pudo extraer el título del capítulo $chapter_num. Omitiendo."
      continue
    fi
  fi
  
  # Extraer las URLs de navegación del front matter
  prev_url=$(echo "$content" | grep "prev_chapter_url:" | sed 's/prev_chapter_url: //')
  if [ -z "$prev_url" ]; then
    if [ "$chapter_num" -eq 1 ]; then
      prev_url="/"
    else
      prev_num=$((chapter_num - 1))
      prev_padded_num=$(printf "%02d" "$prev_num")
      prev_url="/capitulo-$prev_padded_num/"
    fi
  fi
  
  prev_title=$(echo "$content" | grep "prev_chapter_title:" | sed 's/prev_chapter_title: //')
  if [ -z "$prev_title" ]; then
    if [ "$chapter_num" -eq 1 ]; then
      prev_title="\"Índice\""
    else
      prev_num=$((chapter_num - 1))
      prev_title="\"Capítulo $prev_num: Título anterior\""
    fi
  fi
  
  next_url=$(echo "$content" | grep "next_chapter_url:" | sed 's/next_chapter_url: //')
  if [ -z "$next_url" ]; then
    next_num=$((chapter_num + 1))
    next_padded_num=$(printf "%02d" "$next_num")
    next_url="/capitulo-$next_padded_num/"
  fi
  
  next_title=$(echo "$content" | grep "next_chapter_title:" | sed 's/next_chapter_title: //')
  if [ -z "$next_title" ]; then
    next_num=$((chapter_num + 1))
    next_title="\"Capítulo $next_num: Título siguiente\""
  fi
  
  # Extraer el contenido del capítulo (todo después del front matter)
  chapter_content=$(echo "$content" | awk '/^---$/{i++} i==2,EOF{print}' | tail -n +2)
  
  # Si no hay contenido extraído, tomar todo el archivo excepto el front matter
  if [ -z "$chapter_content" ]; then
    chapter_content=$(echo "$content" | awk 'BEGIN{p=0} /^---$/{if(p==0){p=1}else{p=2;next}} p==2{print}')
  fi
  
  # Crear el nuevo front matter con chapter_number separado
  new_front_matter="---
layout: chapter
chapter_number: $chapter_num
title: \"$title\"
prev_chapter_url: $prev_url
prev_chapter_title: $prev_title
next_chapter_url: $next_url
next_chapter_title: $next_title
---"

  # Crear el nuevo contenido completo
  new_content="$new_front_matter

$chapter_content"

  # Guardar el nuevo contenido en el archivo original
  echo "$new_content" > "$chapter_dir/index.md"
  
  echo "Capítulo $chapter_num restaurado correctamente."
done

echo "¡Restauración completada!"
