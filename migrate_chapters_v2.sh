#!/bin/bash

# Script mejorado para migrar capítulos a estructura de carpetas para permalinks
# Este script crea una carpeta para cada capítulo y copia el contenido del archivo original

# Directorio base
BASE_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar"

# Procesar cada capítulo del 1 al 40
for i in {1..40}; do
  # Formatear el número con ceros a la izquierda si es necesario
  if [ $i -lt 10 ]; then
    num="0$i"
  else
    num="$i"
  fi
  
  # Nombre del archivo original (usando comodín para manejar diferentes títulos)
  original_file="$BASE_DIR/Capítulo $num - "*.md
  
  # Verificar si el archivo existe
  if ls $original_file 1> /dev/null 2>&1; then
    # Crear el directorio de destino
    target_dir="$BASE_DIR/capitulo-$num"
    mkdir -p "$target_dir"
    
    # Obtener el nombre real del archivo
    real_file=$(ls "$BASE_DIR/Capítulo $num - "*.md)
    
    # Copiar el contenido al nuevo archivo index.md
    cp "$real_file" "$target_dir/index.md"
    
    # Eliminar la línea de permalink del front matter si existe
    sed -i '' '/permalink:/d' "$target_dir/index.md"
    
    echo "Procesado: $real_file -> $target_dir/index.md"
  else
    echo "No se encontró el capítulo $num"
  fi
done

echo "Migración completada. Todos los capítulos han sido convertidos a estructura de carpetas."
