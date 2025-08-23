import js from "@eslint/js";
import security from "eslint-plugin-security";
import globals from "globals";
import { defineConfig } from "eslint/config";

export default defineConfig([
  {
    files: ["**/*.{js,mjs,cjs}"],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: "module",
      globals: {
        ...globals.node
      }
    },
    plugins: { js, security },
    rules: {
      ...js.configs.recommended.rules,
      ...security.configs.recommended.rules
    }
  },
  {
    // Add Jest environment for test files
    files: ["**/__tests__/**/*.js"],
    languageOptions: {
      globals: {
        ...globals.node,
        jest: "readonly"
      }
    },
    env: {
      jest: true // <-- tells ESLint these are Jest globals
    }
  }
]);
