#!/bin/bash
# Bash-Skript zum Auflisten und Anzeigen des Inhalts von *.dart-Dateien in Markdown
# Speichert Ausgabe in docs/project/flutter-app-fs.md und normalisiert Zeilenumbrüche

# Alle .dart-Dateien rekursiv finden (relativ)
dart_files=$(find . -type f -name "*.dart" | sort)

if [ -z "$dart_files" ]; then
  echo "Keine *.dart-Dateien gefunden."
  exit 0
fi

# Normalisiere Zeilenumbrüche in .dart-Dateien
for file in $dart_files; do
  sed -i 's/\r$//' "$file"  # Entfernt CRLF und lässt LF
done

# Markdown-Datei erstellen
mkdir -p docs/project
{
  echo "# Flutter App Dateistruktur"
  echo ""
  echo "## Verzeichnisbaum der *.dart-Dateien"
  echo ""
  echo "```"
  for file in $dart_files; do
    rel_path="${file#./}"  # Relativ machen
    echo "├── $rel_path"
  done
  echo "```"
  echo ""
  echo "## Inhalt der *.dart-Dateien"
  for file in $dart_files; do
    rel_path="${file#./}"
    echo ""
    echo "### Inhalt von \`$rel_path\`"
    echo "```dart"
    cat "$file" || echo "Fehler beim Lesen von $rel_path"
    echo "```"
  done
} > docs/project/flutter-app-fs.md

# Inhalt auch im Terminal ausgeben
cat docs/project/flutter-app-fs.md