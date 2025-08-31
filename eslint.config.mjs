// eslint.config.mjs

import js from "@eslint/js";
import security from "eslint-plugin-security";
import globals from "globals";
import { defineConfig } from "eslint/config";

export default defineConfig([
  {
    files: ["/*.{js,mjs,cjs}"],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: "module",
      globals: {
        ...globals.node,
      }
    },
    plugins: {
      js,
      security
    },
    rules: {
      ...js.configs.recommended.rules,
      ...security.configs.recommended.rules
    }
  },
  {
    // for  Jest test files
    files: ["tests//*.js"],
    languageOptions: {
      globals: {
        ...globals.jest
      }
    }
  }
]);
