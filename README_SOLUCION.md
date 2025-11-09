# Solución de Problemas con Jekyll

##Problema
Jekyll no puede ejecutarse localmente debido a errores SSL al intentar descargar el tema remoto `patdryburgh/hitchens`.

## Soluciones

### Opción 1: Usar GitHub Pages Directamente (Recomendado)

La forma más simple es trabajar directamente con GitHub Pages:

1. Haz commits de tus cambios
2. Push a GitHub
3. Revisa el sitio en `https://carlosvidal.github.io/Vencedores-de-Sangrar`

GitHub Pages manejará automáticamente el tema remoto sin problemas SSL.

### Opción 2: Usar Docker

Crea un archivo `Dockerfile` en la raíz del proyecto:

```dockerfile
FROM jekyll/jekyll:latest
WORKDIR /srv/jekyll
COPY Gemfile* ./
RUN bundle install
COPY . .
CMD ["jekyll", "serve", "--host", "0.0.0.0"]
```

Luego ejecuta:

```bash
docker build -t mi-jekyll .
docker run -p 4000:4000 -v $(pwd):/srv/jekyll mi-jekyll
```

### Opción 3: Configuración Local Temporal

Si necesitas ver el sitio localmente, modifica temporalmente el `_config.yml`:

1. Comenta el `remote_theme` (ya está comentado)
2. Usa `theme: minima` (ya está configurado)
3. Restaura el `remote_theme` antes de hacer commit

## Configuración Actual

El archivo `_config.yml` está configurado para:
- Usar tema `minima` localmente
- Usar `remote_theme: patdryburgh/hitchens` en GitHub Pages (comentado)

Antes de subir cambios a GitHub, asegúrate de descomentar:
- `remote_theme: patdryburgh/hitchens`
- `- jekyll-remote-theme` en la sección de plugins

## Problema SSL

El error SSL es un problema conocido con Ruby 3.2.2 y OpenSSL en macOS. Las soluciones típicas (actualizar certificados, reinstalar OpenSSL) no funcionan en este caso debido a la complejidad del entorno rbenv.

La mejor solución a largo plazo es usar Docker o trabajar directamente con GitHub Pages.
