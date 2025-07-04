import {
  createNativeStackNavigator,
  NativeStackNavigationProp,
} from "@react-navigation/native-stack";
import { Home } from "./pages/home";
import Camera from "./pages/camera";
import Images from "./pages/images";
import { ImagesCaptured } from "@shapeddev/shaped-expo-plugin";

export type RootStackParamList = {
  Home: any;
  Camera: any;
  Images: {
    images: ImagesCaptured | undefined;
  };
};

export type RootStackProp = NativeStackNavigationProp<
  RootStackParamList,
  "Home"
>;

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
      <Stack.Screen name="Images" component={Images} />
    </Stack.Navigator>
  );
}

