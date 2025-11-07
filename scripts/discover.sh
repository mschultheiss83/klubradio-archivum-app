#!/bin/bash
# Bash-Skript zum Auflisten und Anzeigen des Inhalts von *.dart-Dateien in Markdown
# Speichert Ausgabe in docs/project/flutter-app-fs.md und normalisiert Zeilenumbrüche
# Optimiert für Git Bash / Linux / macOS (pfadsicher)

# **Sicherstellen, dass das Skript bei Fehlern sofort stoppt (Best Practice)**
set -e

# **Setze das aktuelle Verzeichnis als Basis (Projekt-Root)**
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."
OUTPUT_FILE="docs/project/flutter-app-fs.md"

cd "$PROJECT_ROOT" || { echo "Fehler: Konnte nicht ins Projekt-Root ($PROJECT_ROOT) wechseln" >&2; exit 1; }
echo "Debug: Arbeitsverzeichnis gesetzt auf $(pwd)" >&2

# **Alle .dart-Dateien rekursiv und pfadsicher finden**
# `-print0` zur Null-Trennung (pfadsicher), `sort -z` für sortierte Ausgabe
echo "Debug: Suche nach *.dart-Dateien..." >&2
# Speicherung der Dateipfade in einer Variablen mit Null-Trennung
mapfile -d '' DART_FILES < <(find . -type f -name "*.dart" -print0 | sort -z)

if [ ${#DART_FILES[@]} -eq 0 ]; then
  echo "Warnung: Keine *.dart-Dateien gefunden." >&2
  exit 0
fi

echo "Debug: Gefundene Dateien (${#DART_FILES[@]} Stück)." >&2

# **Normalisiere Zeilenumbrüche in .dart-Dateien**
echo "Debug: Normalisiere Zeilenumbrüche..." >&2
for file in "${DART_FILES[@]}"; do
  # Universelle sed-Variante für In-Place-Bearbeitung
  if ! sed -i.bak 's/\r$//' "$file" 2>/dev/null; then
    if ! sed -i '' 's/\r$//' "$file"; then
      echo "Fehler: Konnte Zeilenumbrüche in $file nicht normalisieren." >&2
    fi
  fi
  # Lösche die Backup-Datei, falls sie erstellt wurde
  [ -f "${file}.bak" ] && rm "${file}.bak" 2>/dev/null

  echo "Debug: Normalisiert: $file" >&2
done

# **Markdown-Datei erstellen (Umleitung aller Ausgaben in die Datei, Fehlermeldungen in stderr)**
# Erstelle das Zielverzeichnis, falls es nicht existiert
mkdir -p "$(dirname "$OUTPUT_FILE")"

# Start der Block-Umleitung: stdout geht in $OUTPUT_FILE
{
  echo "# Flutter App Dateistruktur"
  echo ""
  echo "## Verzeichnisbaum der *.dart-Dateien"
  echo ""
  echo "```"
  for file in "${DART_FILES[@]}"; do
    rel_path="${file#./}"
    echo "├── $rel_path"
  done
  echo "```"
  echo ""
  echo "## Inhalt der *.dart-Dateien"
  for file in "${DART_FILES[@]}"; do
    rel_path="${file#./}"
    if [ -f "$file" ] && [ -r "$file" ]; then
      echo ""
      echo "### Inhalt von \`$rel_path\`"
      echo "```dart"
      # Inhalt einlesen und in die Markdown-Datei schreiben
      if ! content=$(cat "$file" 2>/dev/null); then
        echo "Fehler: Konnte Inhalt von $file nicht lesen"
      elif [ -n "$content" ]; then
        echo "$content"
      else
        echo "Warnung: Datei $file ist leer"
      fi
      echo "```"
    else
      echo "Warnung: Datei $rel_path nicht lesbar oder nicht gefunden"
    fi
  done
} > "$OUTPUT_FILE"

# **Debugging: Prüfe, ob die Datei korrekt geschrieben wurde**
if [ -f "$OUTPUT_FILE" ]; then
  echo "Info: Markdown-Datei erfolgreich erstellt: $OUTPUT_FILE" >&2
  # Der Befehl zur Konsolenausgabe des Dateiinhalts wurde hier entfernt.
else
  echo "Fehler: Markdown-Datei konnte nicht erstellt werden: $OUTPUT_FILE" >&2
  exit 1
fi