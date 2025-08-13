#!/bin/bash

# Script simple para restaurar los capítulos desde el backup
# y aplicar el nuevo formato con chapter_number separado

# Directorio de backup
BACKUP_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar/backup MD"

# Restaurar capítulo 4 como prueba
cp "$BACKUP_DIR/Capítulo 04 - La orden.md" /tmp/cap04.md

# Extraer el contenido después del front matter
content=$(cat /tmp/cap04.md)
chapter_content=$(echo "$content" | awk 'BEGIN{p=0} /^---$/{p++; if(p==2) next} p==2{print}')

# Crear el nuevo front matter
new_front_matter="---
layout: chapter
chapter_number: 4
title: \"La orden\"
prev_chapter_url: /capitulo-03/
prev_chapter_title: \"Capítulo 3: Voces de la sierra\"
next_chapter_url: /capitulo-05/
next_chapter_title: \"Capítulo 5: El viaje fatídico\"
---"

# Combinar el nuevo front matter con el contenido
echo "$new_front_matter" > "/Users/carlosvidal/Developer/Vencedores de Sangrar/capitulo-04/index.md"
echo "" >> "/Users/carlosvidal/Developer/Vencedores de Sangrar/capitulo-04/index.md"
echo "$chapter_content" >> "/Users/carlosvidal/Developer/Vencedores de Sangrar/capitulo-04/index.md"

echo "Capítulo 4 restaurado como prueba."
