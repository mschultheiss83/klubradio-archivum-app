// ESLint-Konfiguration in CommonJS-Modul-Format.
// Dies ist notwendig, da ESLint selbst noch nicht vollständig auf ES-Module umgestellt ist.
module.exports = {
  // Verwendet die Standardkonfiguration von ESLint für empfohlene Regeln.
  extends: "eslint:recommended",
  // Legt die Parser-Optionen fest, um ES-Module und moderne Syntax zu unterstützen.
  parserOptions: {
    ecmaVersion: 2022,
    sourceType: "module",
  },
  // Aktiviert bestimmte Umgebungen, um globale Variablen zu erkennen.
  env: {
    node: true,
    es2022: true,
  },
  // Definiert die Regeln für das Projekt.
  rules: {
    // Erzwingt die Verwendung von 'let' oder 'const' anstelle von 'var'.
    "no-var": "error",
    // Verhindert die Deklaration von Variablen, die nie verwendet werden.
    "no-unused-vars": "warn",
    // Erzwingt die Verwendung von Semikolons am Ende von Anweisungen.
    semi: ["error", "always"],
    // Erzwingt doppelte Anführungszeichen für Strings.
    quotes: ["error", "double"],
  },
};
