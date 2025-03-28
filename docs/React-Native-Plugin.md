# Shaped React Native Plugin

Shaped Plugin para React Native.

## Criando um Projeto React Native (Sem Expo)

Para usar este plugin, é necessário um projeto React Native sem **Expo**. Caso ainda não tenha um projeto, crie um utilizando o comando abaixo:

```sh
npx @react-native-community/cli init MeuApp
```

Após a criação do projeto, siga a [documentação oficial do React Native](https://reactnative.dev/docs/getting-started-without-a-framework) para configurar o ambiente.

## Configuração Necessária Antes da Instalação

### Permissões no Android

Se ocorrer algum erro de permissão da câmera no Android, é necessário adicionar a seguinte permissão no arquivo `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
```

### Permissões no iOS

Para utilizar a câmera no iOS, é necessário adicionar a seguinte chave no arquivo `Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Este aplicativo requer acesso à câmera para realizar a captura das fotos necessárias para a avaliação corporal.</string>
```

### Configuração no Android

No arquivo `android/local.properties`, adicione suas credenciais do GitHub para garantir que as dependências privadas sejam resolvidas corretamente, isso deve ser feito localmente, para gerar o build do seu app corretamente pelo github actions configure as mesmas credencias como secrets no seu action. Essas credenciais serão geradas pelo administrador do sistema:

```properties
GITHUB_USER=seu_usuario
GITHUB_TOKEN=seu_token
```

### Configuração no iOS

No início do seu `Podfile`, adicione estas linhas para garantir que o pacote seja resolvido corretamente:

```ruby
source 'https://cdn.cocoapods.org/'
# Se for usar o emulador use esse
source 'https://github.com/shapeddev/shaped-sdk-ios-specs-emulator.git'
# Senão esse
source 'https://github.com/shapeddev/shaped-sdk-ios-specs.git'
```

### Configuração do `.npmrc`

Para que o pacote seja baixado corretamente, adicione um arquivo `.npmrc` na raiz do seu projeto com o seguinte conteúdo:

```ini
@shapeddev:registry=https://npm.pkg.github.com
always-auth=true
//npm.pkg.github.com/:_authToken=${NODE_AUTH_TOKEN}
```

Isso garante que as dependências privadas do repositório sejam acessadas corretamente pelo seu ambiente local e durante a execução do CI/CD.

Esse token vai ser o mesmo utilizado na configuração das credenciais no android.

## Instalação

```sh
npm install @shapeddev/shaped-react-native-plugin
```

## Versões Suportadas

O **Shaped React Native Plugin** foi desenvolvido para ser compatível com a **Nova Arquitetura** e **TurboModules** do React Native.

- **Versão mínima do React Native:** [`0.71.0`](https://www.npmjs.com/package/react-native/v/0.71.0)
- **Versão mínima do React:** [`18.0.0`](https://www.npmjs.com/package/react/v/18.0.0)
- **Versão recomendada do React Native:** [`0.77.1`](https://www.npmjs.com/package/react-native/v/0.77.1)
- **Versão recomendada do React:** [`18.3.1`](https://www.npmjs.com/package/react-native/v/18.3.1)
- **Versão mínima do Android SDK:** `API 24 (Android 7.0 Nougat)`
- **Versão mínima do iOS:** `15.5`

## Dependências Adicionais

Para que o **Shaped React Native Plugin** funcione corretamente, instale também o `@shopify/react-native-skia` na versão `1.11.7`:

```sh
npm install @shopify/react-native-skia@1.11.7
npm install @dr.pogodin/react-native-fs
```

Em seguida, execute `pod install` dentro da pasta `ios/`:

```sh
cd ios && pod install
```

## Uso

O componente principal disponibilizado por esta biblioteca é o `ShapedPluginCamera`, a seguir temos um exemplo de utilização do componente de forma simples, porém temos um app de exemplo mostrando o fluxo completo de utilização que pode ser usado como base, o app está [disponível aqui](https://github.com/shapeddev/shaped-mobile-react-native).

### Exemplo de Uso

```tsx
import React from "react";
import { View } from "react-native";
import { ShapedPluginCamera } from "@shapeddev/shaped-react-native-plugin";

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

