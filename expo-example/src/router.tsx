import { createNativeStackNavigator } from "@react-navigation/native-stack";
import { Home } from "./pages/home";
import Camera from "./pages/camera";

export type RootStackParamList = {
  Home: any;
  Camera: any;
};

const Stack = createNativeStackNavigator<RootStackParamList>();

export function RootStack() {
  return (
    <Stack.Navigator
      screenOptions={{
        headerStyle: {
          backgroundColor: "rgba(62, 65, 82, 1)",
        },
        headerTintColor: "#A5B9C4",
        headerTitleStyle: {
          fontWeight: "bold",
        },
      }}
    >
      <Stack.Screen name="Home" component={Home} />
      <Stack.Screen name="Camera" component={Camera} />
    </Stack.Navigator>
  );
}

