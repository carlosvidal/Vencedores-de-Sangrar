#!/bin/bash

# Script para restaurar directamente los capítulos desde el 4 en adelante
# con el nuevo formato de front matter que separa chapter_number del título

BASE_DIR="/Users/carlosvidal/Developer/Vencedores de Sangrar"
BACKUP_DIR="$BASE_DIR/backup MD"

# Restaurar capítulo 4
mkdir -p "$BASE_DIR/capitulo-04"
chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p==2{print}' "$BACKUP_DIR/Capítulo 04 - La orden.md")
cat > "$BASE_DIR/capitulo-04/index.md" << EOF
---
layout: chapter
chapter_number: 4
title: "La orden"
permalink: /capitulo-04/
prev_chapter_url: /capitulo-03/
prev_chapter_title: "Capítulo 3: Voces de la sierra"
next_chapter_url: /capitulo-05/
next_chapter_title: "Capítulo 5: El viaje fatídico"
---

$chapter_content
EOF
echo "Capítulo 4 restaurado."

# Restaurar capítulo 5
mkdir -p "$BASE_DIR/capitulo-05"
chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p==2{print}' "$BACKUP_DIR/Capítulo 05 - El viaje fatídico.md")
cat > "$BASE_DIR/capitulo-05/index.md" << EOF
---
layout: chapter
chapter_number: 5
title: "El viaje fatídico"
permalink: /capitulo-05/
prev_chapter_url: /capitulo-04/
prev_chapter_title: "Capítulo 4: La orden"
next_chapter_url: /capitulo-06/
next_chapter_title: "Capítulo 6: Primeras sospechas"
---

$chapter_content
EOF
echo "Capítulo 5 restaurado."

# Restaurar capítulo 6
mkdir -p "$BASE_DIR/capitulo-06"
chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p==2{print}' "$BACKUP_DIR/Capítulo 06 - Primeras sospechas.md")
cat > "$BASE_DIR/capitulo-06/index.md" << EOF
---
layout: chapter
chapter_number: 6
title: "Primeras sospechas"
permalink: /capitulo-06/
prev_chapter_url: /capitulo-05/
prev_chapter_title: "Capítulo 5: El viaje fatídico"
next_chapter_url: /capitulo-07/
next_chapter_title: "Capítulo 7: El camino de Montenegro"
---

$chapter_content
EOF
echo "Capítulo 6 restaurado."

# Restaurar capítulo 7
mkdir -p "$BASE_DIR/capitulo-07"
chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p==2{print}' "$BACKUP_DIR/Capítulo 07 - El camino de Montenegro.md")
cat > "$BASE_DIR/capitulo-07/index.md" << EOF
---
layout: chapter
chapter_number: 7
title: "El camino de Montenegro"
permalink: /capitulo-07/
prev_chapter_url: /capitulo-06/
prev_chapter_title: "Capítulo 6: Primeras sospechas"
next_chapter_url: /capitulo-08/
next_chapter_title: "Capítulo 8: Sombras en la noche"
---

$chapter_content
EOF
echo "Capítulo 7 restaurado."

# Restaurar capítulo 8
mkdir -p "$BASE_DIR/capitulo-08"
chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p==2{print}' "$BACKUP_DIR/Capítulo 08 - Sombras en la noche.md")
cat > "$BASE_DIR/capitulo-08/index.md" << EOF
---
layout: chapter
chapter_number: 8
title: "Sombras en la noche"
permalink: /capitulo-08/
prev_chapter_url: /capitulo-07/
prev_chapter_title: "Capítulo 7: El camino de Montenegro"
next_chapter_url: /capitulo-09/
next_chapter_title: "Capítulo 9: La noche en el Rancho Rosa"
---

$chapter_content
EOF
echo "Capítulo 8 restaurado."

# Restaurar capítulo 9
mkdir -p "$BASE_DIR/capitulo-09"
chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p==2{print}' "$BACKUP_DIR/Capítulo 09 - La noche en el Rancho Rosa.md")
cat > "$BASE_DIR/capitulo-09/index.md" << EOF
---
layout: chapter
chapter_number: 9
title: "La noche en el Rancho Rosa"
permalink: /capitulo-09/
prev_chapter_url: /capitulo-08/
prev_chapter_title: "Capítulo 8: Sombras en la noche"
next_chapter_url: /capitulo-10/
next_chapter_title: "Capítulo 10: Madrugada en Huayre"
---

$chapter_content
EOF
echo "Capítulo 9 restaurado."

# Restaurar capítulo 10
mkdir -p "$BASE_DIR/capitulo-10"
chapter_content=$(awk 'BEGIN{p=0} /^---$/{p++; next} p==2{print}' "$BACKUP_DIR/Capítulo 10 - Madrugada en Huayre.md")
cat > "$BASE_DIR/capitulo-10/index.md" << EOF
---
layout: chapter
chapter_number: 10
title: "Madrugada en Huayre"
permalink: /capitulo-10/
prev_chapter_url: /capitulo-09/
prev_chapter_title: "Capítulo 9: La noche en el Rancho Rosa"
next_chapter_url: /capitulo-11/
next_chapter_title: "Capítulo 11: El amanecer en el bosque de piedras"
---

$chapter_content
EOF
echo "Capítulo 10 restaurado."

echo "¡Restauración completada para los capítulos 4-10!"
