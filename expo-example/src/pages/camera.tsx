import { useState } from "react";
import { View, Text, StyleSheet, SafeAreaView } from "react-native";
import { ShapedPluginCamera } from "@shapeddev/shaped-expo-plugin";
import type { DeviceLevel } from "@shapeddev/shaped-expo-plugin";
import LevelChart from "../components/LevelChart";
import { useNavigation } from "@react-navigation/native";
import { RootStackProp } from "../router";
import { useTranslation } from "react-i18next";

const Camera = () => {
  const [poseErrors, setPoseErrors] = useState<string[]>([]);
  const [countdownValue, setCountdownValue] = useState<number | null>();
  const [deviceLevel, setDeviceLevel] = useState<DeviceLevel | undefined>();
  const [frontalValidation, setFrontalValidation] = useState(true);

  const navigation = useNavigation<RootStackProp>();
  const { t, i18n } = useTranslation();

  const errorMessages: Record<string, string> = {
    faceNotDetected: t("camera.errors.faceNotDetected"),
    leftHandNotDetected: t("camera.errors.leftHandNotDetected"),
    rightHandNotDetected: t("camera.errors.rightHandNotDetected"),
    leftFootNotDetected: t("camera.errors.leftFootNotDetected"),
    rightFootNotDetected: t("camera.errors.rightFootNotDetected"),
    angleNotDetected: t("camera.errors.angleNotDetected"),
    armsBelow: t("camera.errors.armsBelow"),
    armsTop: t("camera.errors.armsTop"),
    legsOpen: t("camera.errors.legsOpen"),
    legsClosed: t("camera.errors.legsClosed"),
    rightArmTop: t("camera.errors.rightArmTop"),
    rightArmBelow: t("camera.errors.rightArmBelow"),
    leftArmTop: t("camera.errors.leftArmTop"),
    leftArmBelow: t("camera.errors.leftArmBelow"),
    verifyVolumeSetting: t("camera.errors.verifyVolumeSetting"),
    personIsFar: t("camera.errors.personIsFar"),
    deviceLevelInvalid: t("camera.errors.deviceLevelInvalid"),
  };

  const getErrorMessage = (errors: string[]): string | null => {
    if (errors && errors.length > 0) {
      const key: string | undefined = errors[0];
      return key ? errorMessages[key] || null : null;
    }
    return null;
  };

  const renderContent = () => {
    return (
      <>
        <LevelChart
          isValid={deviceLevel?.isValid}
          offsetX={deviceLevel?.x}
          offsetY={deviceLevel?.y}
        />
        <View style={styles.header}>
          <Text style={styles.title}>
            {frontalValidation ? t("camera.poseFront") : t("camera.poseSide")}
          </Text>
          {countdownValue !== null && Number(countdownValue) > 0 && (
            <Text style={styles.count}>{countdownValue}</Text>
          )}
          <Text style={styles.titleErrors}>
            {getErrorMessage(poseErrors) || ""}
          </Text>
        </View>
        <View style={styles.cameraContainer}>
          <ShapedPluginCamera
            onCountdown={(countdown) => {
              setCountdownValue(countdown);
            }}
            onDeviceLevel={setDeviceLevel}
            onChangeFrontalValidation={setFrontalValidation}
            onImagesCaptured={(values) => {
              navigation.replace("Images", {
                images: values,
              });
            }}
            onErrorsPose={(errors) => {
              setPoseErrors(errors);
            }}
            language={i18n.language}
          />
        </View>
      </>
    );
  };

  return (
    <SafeAreaView style={styles.safeContainer}>{renderContent()}</SafeAreaView>
  );
};

export default Camera;

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
  },
});

