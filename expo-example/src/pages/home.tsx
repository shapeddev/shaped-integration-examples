import { useNavigation } from "@react-navigation/native";
import { NativeStackNavigationProp } from "@react-navigation/native-stack";
import { SafeAreaView, StyleSheet, Text, TouchableOpacity } from "react-native";
import { RootStackParamList } from "../router";

type NavigationProps = NativeStackNavigationProp<RootStackParamList, "Home">;

export function Home() {
  const navigation = useNavigation<NavigationProps>();

  const onNavigateCamera = () => {
    navigation.navigate("Camera");
  };

  return (
    <SafeAreaView style={styles.safeContainer}>
      <Text style={styles.title}>
        Aplicativo de exemplo da utilização do componente ShapedPluginCamera
      </Text>
      <TouchableOpacity style={styles.button} onPress={onNavigateCamera}>
        <Text style={styles.buttonText}>Começar</Text>
      </TouchableOpacity>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeContainer: {
    flex: 1,
    backgroundColor: "rgba(62, 65, 82, 1)",
    justifyContent: "center",
    alignItems: "center",
  },
  title: {
    fontSize: 20,
    fontWeight: "bold",
    textAlign: "center",
    padding: 8,
    color: "#A5B9C4",
  },
  button: {
    backgroundColor: "#6BECFF",
    padding: 12,
    borderRadius: 12,
    marginTop: 16,
  },
  buttonText: {
    fontSize: 20,
    fontWeight: "bold",
    color: "#3E4152",
  },
});

