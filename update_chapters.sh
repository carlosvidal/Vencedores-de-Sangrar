#!/bin/bash

# Script para actualizar el front matter de todos los capítulos
# Extrae el número del capítulo y lo coloca en una variable separada

for chapter_dir in capitulo-*; do
  # Ignorar directorios que no siguen el patrón correcto o no contienen index.md
  if [[ ! -d "$chapter_dir" || ! -f "$chapter_dir/index.md" ]]; then
    continue
  fi
  
  # Extraer el número del capítulo del nombre del directorio
  chapter_num=$(echo $chapter_dir | sed -E 's/capitulo-0?([0-9]+)/\1/')
  
  # Leer el archivo actual
  content=$(cat "$chapter_dir/index.md")
  
  # Verificar si ya tiene chapter_number (para evitar actualizar archivos ya actualizados)
  if [[ $content == *"chapter_number:"* ]]; then
    echo "El capítulo $chapter_num ya está actualizado. Omitiendo."
    continue
  fi
  
  # Extraer el título actual
  title=$(echo "$content" | grep -E 'title: "Capítulo [0-9]+: ' | sed -E 's/title: "Capítulo [0-9]+: (.*)"$/\1"/')
  
  if [[ -z "$title" ]]; then
    echo "No se pudo extraer el título del capítulo $chapter_num. Omitiendo."
    continue
  fi
  
  # Crear el nuevo front matter
  old_front_matter=$(echo "$content" | awk '/^---$/{i++} i==1,i==2{print}' | sed '$d')
  new_front_matter="---\nlayout: chapter\nchapter_number: $chapter_num\ntitle: $title\n"
  
  # Extraer las URLs de navegación
  prev_url=$(echo "$content" | grep "prev_chapter_url:" | sed 's/prev_chapter_url: //')
  prev_title=$(echo "$content" | grep "prev_chapter_title:" | sed 's/prev_chapter_title: //')
  next_url=$(echo "$content" | grep "next_chapter_url:" | sed 's/next_chapter_url: //')
  next_title=$(echo "$content" | grep "next_chapter_title:" | sed 's/next_chapter_title: //')
  
  # Añadir las URLs de navegación al nuevo front matter
  new_front_matter="${new_front_matter}prev_chapter_url: $prev_url\nprev_chapter_title: $prev_title\nnext_chapter_url: $next_url\nnext_chapter_title: $next_title\n---"
  
  # Reemplazar el front matter antiguo con el nuevo
  new_content=$(echo "$content" | awk -v new="$new_front_matter" '/^---$/{i++} i==2{i++; print new; next} i>=3{print}')
  
  # Guardar el nuevo contenido
  echo "$new_content" > "$chapter_dir/index.md"
  
  echo "Capítulo $chapter_num actualizado correctamente."
done

echo "¡Todos los capítulos han sido actualizados!"
