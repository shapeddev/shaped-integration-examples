import i18n from "i18next";
import { initReactI18next } from "react-i18next";
import * as Localization from "expo-localization";

import en from "./locales/en.json";
import pt from "./locales/pt.json";
import es from "./locales/es.json";

export const LANGUAGE_STORAGE_KEY = "APP_LANGUAGE";

export const availableLanguages = {
  "en-US": "English",
  "pt-BR": "Português",
  "es-ES": "Español",
} as const;

const resources = {
  "en-US": { translation: en },
  "pt-BR": { translation: pt },
  "es-ES": { translation: es },
};

const bestLanguage = Localization.getLocales()[0]?.languageTag ?? "pt-BR";

i18n.use(initReactI18next).init({
  resources,
  compatibilityJSON: "v4",
  lng: bestLanguage,
  fallbackLng: "pt-BR",
  interpolation: {
    escapeValue: false,
  },
});

export default i18n;

