# Shaped Expo Plugin

Shaped Plugin para **Expo**.

## Criando um Projeto Expo

Para utilizar este plugin, é necessário um projeto Expo. Caso ainda não tenha um projeto, crie um utilizando o comando abaixo:

```sh
npx create-expo-app@latest MeuApp
```

Após a criação do projeto, siga a [documentação oficial do Expo](https://docs.expo.dev/tutorial/create-your-first-app/) para configurar o ambiente.

Para garantir compatibilidade, utilize o seguinte comando para instalar as versões recomendadas:

```sh
npx expo install expo@~52.0.37 react@18.3.1 react-native@0.76.7
```

---

## Configuração Necessária Antes da Instalação

### 1. Instalar Dependências Adicionais

Este plugin depende das bibliotecas **@shopify/react-native-skia** e **react-native-reanimated**. Para instalá-las corretamente, utilize:

```sh
npx expo install @shopify/react-native-skia@1.11.7 react-native-reanimated
```

OBS: Se acontecer algum erro referente ao react-native-reanimated seja o [manual do pacote.](https://docs.swmansion.com/react-native-reanimated/docs/fundamentals/getting-started/)

### 2. Instalar o expo-dev-client

Para utilizar o pacote é preciso que seu app utilize o [development build](https://docs.expo.dev/develop/development-builds/create-a-build/) para isso instale o **expo-dev-client**:

```sh
npx expo install expo-dev-client
```

### 3. Configuração no Android

No arquivo `android/local.properties`, adicione suas credenciais do GitHub para garantir que as dependências privadas sejam resolvidas corretamente. Isso deve ser feito localmente. Para gerar o build do seu app corretamente via GitHub Actions, configure as mesmas credenciais como **secrets** no seu pipeline CI/CD. Essas credenciais serão fornecidas pelo administrador do sistema:

```properties
GITHUB_USER=seu_usuario
GITHUB_TOKEN=seu_token
```

### 4. Configuração no iOS

No início do seu `Podfile`, adicione estas linhas para garantir que o pacote seja resolvido corretamente:

```ruby
source 'https://cdn.cocoapods.org/'
source 'https://github.com/shapeddev/shaped-sdk-ios-specs.git'
```

### 5. Configuração do build.gradle

No arquivo `android/build.gradle`, adicione as seguintes linhas **abaixo** da linha contendo:

```gradle
allprojects {}
```

Adicione:

```gradle
def localProperties = new Properties()
localProperties.load(rootProject.file("local.properties").newDataInputStream())

def githubUser = System.getenv("GITHUB_USER") ?: localProperties.getProperty("GITHUB_USER")
def githubToken = System.getenv("GITHUB_TOKEN") ?: localProperties.getProperty("GITHUB_TOKEN")
```

Em seguida, dentro da seção `allprojects`, logo abaixo da linha contendo:

```gradle
maven { url 'https://www.jitpack.io' }
```

Adicione:

```gradle
maven {
    url "https://maven.pkg.github.com/shapeddev/shaped-sdk-packages"
    credentials {
        username = githubUser
        password = githubToken
    }
}
```

Essa configuração garante que, localmente, as variáveis sejam carregadas a partir do `local.properties`, enquanto no ambiente de CI/CD, as credenciais sejam lidas diretamente das variáveis de ambiente configuradas.

### 6. Permissões no Android

Se ocorrer erro de permissão da câmera no Android, adicione a seguinte permissão no arquivo `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
```

### 7. Permissões no iOS

Para utilizar a câmera no iOS, adicione a seguinte chave no arquivo `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Este aplicativo requer acesso à câmera para capturar imagens.</string>
```

### 8. Configuração do `.npmrc`

Caso tenha problemas ao baixar o pacote, adicione um arquivo `.npmrc` na raiz do projeto:

```ini
@shapeddev:registry=https://npm.pkg.github.com
always-auth=true
//npm.pkg.github.com/:_authToken=${NODE_AUTH_TOKEN}
```

---

## Instalação do Plugin

Agora, instale o plugin **Shaped Expo Plugin** no seu projeto:

```sh
npm install @shapeddev/shaped-expo-plugin
```

Após a instalação, execute:

```sh
npx expo prebuild
```

E então rode o comando para iOS ou Android:

```sh
npx expo run:ios
# ou
npx expo run:android
```

---

## Uso

O componente principal disponibilizado por esta biblioteca é o `ShapedPluginCamera`. Aqui está um exemplo de utilização:

### Exemplo de Uso

```tsx
import React from "react";
import { View } from "react-native";
import { ShapedPluginCamera } from "@shapeddev/shaped-expo-plugin";

const App = () => {
  return (
    <View style={{ flex: 1 }}>
      <ShapedPluginCamera
        onImagesCaptured={(capturedImages) => console.log(capturedImages)}
        onErrorsPose={(errors) => console.log(errors)}
        onCountdown={(countdown) => console.log(countdown)}
        onDeviceLevel={(level) => console.log(level)}
        onChangeFrontalValidation={(frontalValidation) =>
          console.log(frontalValidation)
        }
      />
    </View>
  );
};

export default App;
```

## Propriedades (Props) do `ShapedPluginCamera`

| Propriedade                     | Tipo                                   | Descrição                                                                                               |
| ------------------------------- | -------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **`onImagesCaptured`**          | `(images?: ImagesCaptured) => void`    | Callback chamado quando imagens são capturadas. Essas são as imagens que devem ser enviadas para a API. |
| **`onErrorsPose`**              | `(errors: string[]) => void`           | Callback chamado quando erros ocorrem durante a captura da pose.                                        |
| **`onCountdown`**               | `(countdown: number \| null) => void`  | Callback chamado quando é iniciado o countdown para a captura da imagem.                                |
| **`onDeviceLevel`**             | `(level?: DeviceLevel) => void`        | Callback que envia os dados referente ao nível do device com base no acelerômetro.                      |
| **`onChangeFrontalValidation`** | `(frontalValidation: boolean) => void` | Callback chamado quando a validação frontal muda.                                                       |
| **`settings`**                  | `Settings`                             | Configurações para controle da câmera e detecção de poses.                                              |

## Lista de Erros Possíveis

Os seguintes erros podem ser retornados pelo `onErrorsPose`:

```ts
const errorKeys = [
  'faceNotDetected' // Caminhe para trás, enquadrando o corpo inteiro,
  'leftHandNotDetected' // Mão esquerda não está aparecendo na imagem,
  'rightHandNotDetected'// Mão direita não está aparecendo na imagem,
  'leftFootNotDetected'// Pé esquerdo não está aparecendo na imagem,
  'rightFootNotDetected'// Pé direito não está aparecendo na imagem,
  'angleNotDetected'// Ajuste sua postura,
  'armsBelow'// Levante os braços,
  'armsTop',// Abaixe os braços
  'legsOpen',// Aproxime as pernas
  'legsClosed',// Afaste as pernas
  'rightArmTop',// Abaixe o braço direito
  'rightArmBelow',// Levante o braço direito
  'leftArmTop',// Abaixe o braço esquerdo
  'leftArmBelow',// Levante o braço direito
  'verifyVolumeSetting',// Por favor verifique o volume do dispositivo (Mensagem somente de aviso não é um erro)
  'personIsFar'// Aproxime-se da câmera,
  'deviceLevelInvalid',// Afaste o ângulo do seu device
] as const;
```

## Tipos Exportados

### `ImageResult`

Representa o resultado de uma imagem processada.

```ts
export interface ImageResult {
  base64: string; // Imagem em formato base64
  size: { width: number; height: number }; // Tamanho da imagem
}
```

### `ImagesCaptured`

Armazena imagens capturadas frontal e lateralmente.

```ts
export interface ImagesCaptured {
  frontalImage?: ImageHigh; // Imagem frontal capturada
  sideImage?: ImageHigh; // Imagem lateral capturada
}
```

### `ImageHigh`

Representa uma imagem capturada em alta qualidade.

```ts
export interface ImageHigh {
  uri: string; // URI do arquivo da imagem
  name: string; // Nome do arquivo da imagem
  type: string; // Tipo MIME da imagem (ex: "image/jpeg")
}
```

### `Pose`

Representa os dados de uma pose detectada.

```ts
export interface Pose {
  isValid: boolean; // Indica se a pose é válida
  shouldAdvanceToNextPhoto: boolean; // Se deve capturar a próxima foto automaticamente
  errors: string[]; // Lista de erros detectados na pose
  countdown: number | null; // Tempo restante para capturar a imagem
  images?: { frontalImage?: ImageResult; sideImage?: ImageResult }; // Imagens capturadas
  deviceLevel?: DeviceLevel; // Nível do dispositivo
  pose: { landmarks: PoseLandmark[]; connectionsColor: Joint[] }; // Dados da pose
}
```

### `DeviceLevel`

Representa o nível do dispositivo baseado no acelerômetro.

```ts
export interface DeviceLevel {
  x: number; // Inclinação do dispositivo no eixo X
  y: number; // Inclinação do dispositivo no eixo Y
  isValid: boolean; // Indica se o nível do dispositivo está dentro dos parâmetros aceitáveis
}
```

### `Settings`

Configurações do plugin. Caso não sejam fornecidos valores, serão utilizados os padrões abaixo:

```ts
export interface Settings {
  timerSeconds?: number; // Tempo padrão para captura da foto (padrão: 3 segundos)
  accelerometerRangeXStart?: number; // Início do intervalo do acelerômetro no eixo X (padrão: -4)
  accelerometerRangeXEnd?: number; // Fim do intervalo do acelerômetro no eixo X (padrão: 4)
  accelerometerRangeYStart?: number; // Início do intervalo do acelerômetro no eixo Y (padrão: 96)
  accelerometerRangeYEnd?: number; // Fim do intervalo do acelerômetro no eixo Y (padrão: 104)
  minCameraWidth?: number; // Largura mínima da câmera (opcional)
  minCameraHeight?: number; // Altura mínima da câmera (opcional)
  maxCameraWidth?: number; // Largura máxima da câmera (padrão: maior resolução disponível do dispositivo)
  maxCameraHeight?: number; // Altura máxima da câmera (padrão: maior resolução disponível do dispositivo)
}
```

### `PoseLandmark`

Representa um ponto de articulação detectado na pose.

```ts
export interface PoseLandmark {
  inFrameLikelihood: number; // Probabilidade de o ponto estar visível na imagem
  position: Point3D; // Coordenadas do ponto detectado
  type: PoseLandmarkType; // Tipo do marco detectado
}
```

### `Point3D`

Representa uma coordenada tridimensional no espaço da imagem.

```ts
export interface Point3D {
  x: number; // Coordenada X do ponto
  y: number; // Coordenada Y do ponto
  z: number; // Profundidade do ponto
}
```

