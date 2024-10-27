#!/bin/bash

if curl -s --head http://localhost | grep "200 OK" > /dev/null; then
    echo "Test de la page d'accueil : OK"
else
    echo "Test de la page d'accueil : ÉCHEC"
    exit 1
fi

if curl -s --head http://localhost/about.html | grep "200 OK" > /dev/null; then
    echo "Test de la page 'about.html' : OK"
else
    echo "Test de la page 'about.html' : ÉCHEC"
    exit 1
fi

