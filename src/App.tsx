import {useState} from 'react';
import {
  View,
  Text,
  StyleSheet,
  SafeAreaView,
  ScrollView,
  Image,
} from 'react-native';
import {ShapedPluginCamera} from '@shapeddev/shaped-react-native-plugin';
import type {
  DeviceLevel,
  ImagesCaptured,
} from '@shapeddev/shaped-react-native-plugin';
import LevelChart from './LevelChart';

const App = () => {
  const [images, setImages] = useState<ImagesCaptured | undefined>();
  const [poseErrors, setPoseErrors] = useState<string[]>([]);
  const [countdownValue, setCountdownValue] = useState<number | null>();
  const [deviceLevel, setDeviceLevel] = useState<DeviceLevel | undefined>();
  const [frontalValidation, setFrontalValidation] = useState(true);
  const [success, setSuccess] = useState(false);

  const errorMessages: Record<string, string> = {
    faceNotDetected: 'Caminhe para trás, enquadrando o corpo inteiro',
    leftHandNotDetected: 'Mão esquerda não está aparecendo na imagem',
    rightHandNotDetected: 'Mão direita não está aparecendo na imagem',
    leftFootNotDetected: 'Pé esquerdo não está aparecendo na imagem',
    rightFootNotDetected: 'Pé direito não está aparecendo na imagem',
    angleNotDetected: 'Ajuste sua postura',
    armsBelow: 'Levante os braços',
    armsTop: 'Abaixe os braços',
    legsOpen: 'Aproxime as pernas',
    legsClosed: 'Afaste as pernas',
    rightArmTop: 'Abaixe o braço direito',
    rightArmBelow: 'Levante o braço direito',
    leftArmTop: 'Abaixe o braço esquerdo',
    leftArmBelow: 'Levante o braço esquerdo',
    verifyVolumeSetting: 'Por favor verifique o volume do dispositivo',
    personIsFar: 'Aproxime-se da câmera',
    deviceLevelInvalid: 'Afaste o ângulo do seu device',
  };

  const getErrorMessage = (errors: string[]): string | null => {
    if (errors && errors.length > 0) {
      const key: string | undefined = errors[0];
      return key ? errorMessages[key] || null : null;
    }
    return null;
  };

  const renderContent = () => {
    if (success) {
      return (
        <ScrollView
          horizontal
          pagingEnabled
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={styles.imageScrollContainer}>
          {images?.frontalImage?.base64 && (
            <Image
              source={{
                uri: `data:image/png;base64,${images.frontalImage.base64}`,
              }}
              style={styles.image}
            />
          )}
          {images?.sideImage?.base64 && (
            <Image
              source={{
                uri: `data:image/png;base64,${images.sideImage.base64}`,
              }}
              style={styles.image}
            />
          )}
        </ScrollView>
      );
    }

    return (
      <>
        <LevelChart
          isValid={deviceLevel?.isValid}
          offsetX={deviceLevel?.x}
          offsetY={deviceLevel?.y}
        />
        <View style={styles.header}>
          <Text style={styles.title}>
            {frontalValidation ? 'Pose Frontal' : 'Pose Lateral'}
          </Text>
          {countdownValue !== null && Number(countdownValue) > 0 && (
            <Text style={styles.count}>{countdownValue}</Text>
          )}
          <Text style={styles.titleErrors}>
            {getErrorMessage(poseErrors) || ''}
          </Text>
        </View>
        <View style={styles.cameraContainer}>
          <ShapedPluginCamera
            onImagesCaptured={values => {
              setImages(values);
              setSuccess(true);
            }}
            onErrorsImage={(errors, countdown) => {
              setPoseErrors(errors);
              setCountdownValue(countdown);
            }}
            onDeviceLevel={setDeviceLevel}
            onChangeFrontalValidation={setFrontalValidation}
          />
        </View>
      </>
    );
  };

  return (
    <SafeAreaView style={styles.safeContainer}>{renderContent()}</SafeAreaView>
  );
};

export default App;

const styles = StyleSheet.create({
  safeContainer: {
    flex: 1,
    backgroundColor: 'rgba(62, 65, 82, 1)',
    justifyContent: 'flex-start',
    alignItems: 'center',
  },
  header: {
    height: 100,
    width: '100%',
    flexDirection: 'column',
  },
  cameraContainer: {
    flex: 1,
    width: '100%',
    justifyContent: 'center',
    alignItems: 'center',
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 8,
    textAlign: 'center',
    color: 'white',
  },
  count: {
    fontSize: 30,
    fontWeight: 'bold',
    marginBottom: 8,
    textAlign: 'center',
    color: 'white',
  },
  titleErrors: {
    fontSize: 20,
    color: 'white',
    fontWeight: 'bold',
    marginBottom: 8,
    textAlign: 'center',
  },
  imageScrollContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
  },
  image: {
    width: 300,
    height: 400,
    marginHorizontal: 10,
  },
});
