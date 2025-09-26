import React, { useState } from "react";
import { StyleSheet, Text, TouchableOpacity } from "react-native";
import { Appbar, Menu } from "react-native-paper";
import { useTranslation } from "react-i18next";
import { availableLanguages } from "../i18n/i18n";
import { NativeStackHeaderProps } from "@react-navigation/native-stack";

type LanguageCode = keyof typeof availableLanguages;

const flagMap: Record<LanguageCode, string> = {
  "en-US": "🇺🇸",
  "pt-BR": "🇧🇷",
  "es-ES": "🇪🇸",
};

export default function HeaderWithLanguageMenu({
  navigation,
  route,
  options,
  back,
}: NativeStackHeaderProps) {
  const { i18n } = useTranslation();
  const title = options.title ?? route.name;

  const currentLang = (
    Object.keys(availableLanguages).includes(i18n.language)
      ? i18n.language
      : "pt-BR"
  ) as LanguageCode;

  const [menuVisible, setMenuVisible] = useState(false);

  const openMenu = () => setMenuVisible(true);
  const closeMenu = () => setMenuVisible(false);

  const handleChangeLanguage = async (lang: LanguageCode) => {
    await i18n.changeLanguage(lang);
    closeMenu();
  };

  return (
    <Appbar.Header style={styles.header}>
      {back ? <Appbar.BackAction onPress={navigation.goBack} /> : null}

      <Appbar.Content title={title} titleStyle={styles.title} />

      <Menu
        visible={menuVisible}
        onDismiss={closeMenu}
        anchor={
          <TouchableOpacity style={styles.anchor} onPress={openMenu}>
            <Text style={styles.flag}>{flagMap[currentLang]}</Text>
          </TouchableOpacity>
        }
      >
        {Object.entries(availableLanguages).map(([code, label]) => (
          <Menu.Item
            key={code}
            onPress={() => handleChangeLanguage(code as LanguageCode)}
            title={`${flagMap[code as LanguageCode]} ${label}`}
          />
        ))}
      </Menu>
    </Appbar.Header>
  );
}

const styles = StyleSheet.create({
  header: {
    backgroundColor: "rgba(62, 65, 82, 1)",
    elevation: 4,
  },
  title: {
    color: "#A5B9C4",
    fontWeight: "bold",
  },
  anchor: {
    marginRight: 12,
    padding: 6,
  },
  flag: {
    fontSize: 22,
  },
});

