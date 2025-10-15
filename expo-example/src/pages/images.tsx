import {
  StyleSheet,
  SafeAreaView,
  ScrollView,
  Image,
  TouchableOpacity,
  Text,
} from "react-native";
import { RouteProp, useNavigation, useRoute } from "@react-navigation/native";
import { RootStackParamList } from "../router";
import { NativeStackNavigationProp } from "@react-navigation/native-stack";

type NavigationProps = NativeStackNavigationProp<RootStackParamList, "Images">;

const Images = () => {
  type ScreenRouteProp = RouteProp<RootStackParamList, "Images">;
  const route = useRoute<ScreenRouteProp>();
  const images = route.params.images;
  const navigation = useNavigation<NavigationProps>();

  const resetImages = () => {
    navigation.navigate("Camera");
  };

  return (
    <SafeAreaView style={styles.safeContainer}>
      <ScrollView
        horizontal
        pagingEnabled
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.imageScrollContainer}
      >
        {images?.frontalImage?.uri && (
          <Image
            source={{
              uri: images.frontalImage.uri,
            }}
            style={styles.image}
          />
        )}
        {images?.sideImage?.uri && (
          <Image
            source={{
              uri: images.sideImage.uri,
            }}
            style={styles.image}
          />
        )}
      </ScrollView>
      <TouchableOpacity style={styles.button} onPress={resetImages}>
        <Text style={styles.buttonText}>Voltar</Text>
      </TouchableOpacity>
    </SafeAreaView>
  );
};

export default Images;

const styles = StyleSheet.create({
  safeContainer: {
    flex: 1,
    backgroundColor: "rgba(62, 65, 82, 1)",
    justifyContent: "flex-start",
    alignItems: "center",
  },
  header: {
    height: 100,
    width: "100%",
    flexDirection: "column",
  },
  cameraContainer: {
    flex: 1,
    width: "100%",
    justifyContent: "center",
    alignItems: "center",
  },
  title: {
    fontSize: 20,
    fontWeight: "bold",
    marginBottom: 8,
    textAlign: "center",
    color: "white",
  },
  count: {
    fontSize: 30,
    fontWeight: "bold",
    marginBottom: 8,
    textAlign: "center",
    color: "white",
  },
  titleErrors: {
    fontSize: 20,
    color: "white",
    fontWeight: "bold",
    marginBottom: 8,
    textAlign: "center",
  },
  imageScrollContainer: {
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
  },
  image: {
    width: 300,
    height: 400,
    marginHorizontal: 10,
    objectFit: "contain",
  },
  button: {
    backgroundColor: "#6BECFF",
    padding: 12,
    borderRadius: 12,
    marginBottom: 20,
  },
  buttonText: {
    fontSize: 20,
    fontWeight: "bold",
    color: "#3E4152",
  },
});

