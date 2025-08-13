#!/bin/bash

# Script para migrar capítulos a estructura de carpetas para permalinks
# Este script crea una carpeta para cada capítulo y copia el contenido del archivo original

# Directorio base
BASE_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar"

# Procesar cada archivo de capítulo
for file in "$BASE_DIR"/Capítulo*; do
  # Extraer el número del capítulo (asumiendo formato "Capítulo XX - Título.md")
  chapter_num=$(echo "$file" | grep -o '[0-9]\+' | head -1)
  
  # Formatear el número con ceros a la izquierda si es necesario
  if [ ${#chapter_num} -eq 1 ]; then
    formatted_num="0$chapter_num"
  else
    formatted_num="$chapter_num"
  fi
  
  # Crear el directorio de destino
  target_dir="$BASE_DIR/capitulo-$formatted_num"
  mkdir -p "$target_dir"
  
  # Copiar el contenido al nuevo archivo index.md
  cp "$file" "$target_dir/index.md"
  
  # Eliminar la línea de permalink del front matter
  sed -i '' '/permalink:/d' "$target_dir/index.md"
  
  echo "Procesado: $file -> $target_dir/index.md"
done

echo "Migración completada. Todos los capítulos han sido convertidos a estructura de carpetas."
