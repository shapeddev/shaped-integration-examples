import { NavigationContainer } from "@react-navigation/native";
import { RootStack } from "./router";
import { StatusBar } from "expo-status-bar";
import { PaperProvider } from "react-native-paper";

export default function App() {
  return (
    <PaperProvider>
      <NavigationContainer>
        <StatusBar />
        <RootStack />
      </NavigationContainer>
    </PaperProvider>
  );
}

