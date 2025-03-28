import { NavigationContainer } from "@react-navigation/native";
import { RootStack } from "./router";
import { StatusBar } from "expo-status-bar";

export default function App() {
  return (
    <NavigationContainer>
      <StatusBar />
      <RootStack />
    </NavigationContainer>
  );
}

