#!/bin/bash

# Définir la racine du système de fichiers à parcourir
root_dir="/"

# Parcourir récursivement tous les fichiers du système
find "$root_dir" -type f -print0 | while IFS= read -r -d '' file; do
    # Exclure le script lui-même
    if [[ $file == *"/find_404CTF.sh" ]]; then
        continue
    fi
    
    # Utiliser grep pour chercher la chaîne "404CTF" dans le fichier
    # -l arrête la recherche après la première correspondance
    # -q rend grep silencieux (pas de sortie standard)
    if grep -lq "404CTF" "$file"; then
        # Si la chaîne a été trouvée, afficher le contenu du fichier
        echo "Found in: $file"
        cat "$file"
    fi
done
