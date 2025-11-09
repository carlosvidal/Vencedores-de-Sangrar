#!/bin/bash

# Script para iniciar Jekyll sin errores SSL
# Esto es solo para desarrollo local

export RUBY_SSL_VERIFY=0
export SSL_CERT_DIR=/etc/ssl/certs

bundle exec jekyll serve
