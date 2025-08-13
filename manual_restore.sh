#!/bin/bash

# Script para restaurar manualmente todos los capítulos
# Este script procesa cada capítulo individualmente para mayor control

BASE_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar"
BACKUP_DIR="$BASE_DIR/backup MD"

# Función para restaurar un capítulo específico
restore_chapter() {
  local chapter_num=$1
  local padded_num=$(printf "%02d" $chapter_num)
  local chapter_dir="$BASE_DIR/capitulo-$padded_num"
  
  # Buscar el archivo de backup correspondiente
  local backup_file=""
  for file in "$BACKUP_DIR"/Capítulo*; do
    if [[ "$file" =~ Capítulo[[:space:]]+$chapter_num[[:space:]]+ ]]; then
      backup_file="$file"
      break
    fi
  done
  
  if [ -z "$backup_file" ]; then
    echo "No se encontró archivo de backup para el capítulo $chapter_num"
    return 1
  fi
  
  echo "Restaurando capítulo $chapter_num desde $backup_file"
  
  # Extraer el título del nombre del archivo
  local title=$(basename "$backup_file" | sed -E 's/Capítulo[[:space:]]+[0-9]+[[:space:]]+-[[:space:]]+(.*).md/\1/')
  
  # Leer el contenido del archivo de backup
  local content=$(cat "$backup_file")
  
  # Extraer el contenido después del front matter
  local chapter_content=$(echo "$content" | awk 'BEGIN{p=0} /^---$/{p++; if(p==2) next} p==2{print}')
  
  # Si no hay contenido extraído, intentar otro método
  if [ -z "$chapter_content" ]; then
    chapter_content=$(echo "$content" | sed -n '/^---$/,/^---$/!p')
  fi
  
  # Determinar las URLs de navegación
  local prev_url prev_title next_url next_title
  
  if [ "$chapter_num" -eq 1 ]; then
    prev_url="/"
    prev_title="\"Índice\""
  else
    prev_num=$((chapter_num - 1))
    prev_padded_num=$(printf "%02d" "$prev_num")
    prev_url="/capitulo-$prev_padded_num/"
    
    # Buscar el título del capítulo anterior
    for file in "$BACKUP_DIR"/Capítulo*; do
      if [[ "$file" =~ Capítulo[[:space:]]+$prev_num[[:space:]]+ ]]; then
        prev_title_text=$(basename "$file" | sed -E 's/Capítulo[[:space:]]+[0-9]+[[:space:]]+-[[:space:]]+(.*).md/\1/')
        prev_title="\"Capítulo $prev_num: $prev_title_text\""
        break
      fi
    done
    
    if [ -z "$prev_title" ]; then
      prev_title="\"Capítulo $prev_num: Título anterior\""
    fi
  fi
  
  next_num=$((chapter_num + 1))
  next_padded_num=$(printf "%02d" "$next_num")
  next_url="/capitulo-$next_padded_num/"
  
  # Buscar el título del capítulo siguiente
  for file in "$BACKUP_DIR"/Capítulo*; do
    if [[ "$file" =~ Capítulo[[:space:]]+$next_num[[:space:]]+ ]]; then
      next_title_text=$(basename "$file" | sed -E 's/Capítulo[[:space:]]+[0-9]+[[:space:]]+-[[:space:]]+(.*).md/\1/')
      next_title="\"Capítulo $next_num: $next_title_text\""
      break
    fi
  done
  
  if [ -z "$next_title" ]; then
    next_title="\"Capítulo $next_num: Título siguiente\""
  fi
  
  # Crear el nuevo front matter
  local new_front_matter="---
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
}

# Restaurar capítulos del 4 al 40
for i in {4..40}; do
  restore_chapter $i
done

echo "¡Restauración completada!"
