#!/usr/bin/env bash

# Reminder to regularly run spelling and grammatical checker
echo "*** Remember to run 'hunspell <file>' and 'grammalecte-cli -roff typo_tiret_début_ligne esp_début_ligne -owe -iff xyz.md' from time to time ***"

# Output directory is configure here
OUTPUT_DIR="Rendus"

# Render markdown files using pandoc
for md_file in TP*.md; do
    pdf_file="${OUTPUT_DIR}/${md_file%.md}.pdf"
    echo "convert ${md_file} -> ${pdf_file} using pandoc"
    pandoc -f markdown -t latex -o "${pdf_file}" "${md_file}"
done

# Render slides using LibreOffice
loimpress --convert-to pdf --outdir "${OUTPUT_DIR}" ./*.odp