# Shaped React Native Plugin

Shaped Plugin para React Native.

## Como Rodar o App de Exemplo

Para rodar o app de exemplo, siga os passos abaixo:

### Clone o repositório e entre na pasta do projeto

```sh
git clone https://github.com/shapeddev/shaped-mobile-react-native.git
cd shaped-mobile-react-native
```

### Navegue até a pasta do app de exemplo

```sh
cd react-native-example
```

### Configure as credenciais

No arquivo `android/local.properties`, adicione suas credenciais disponibilizadas pelo administrador para garantir que as dependências privadas sejam resolvidas corretamente:

```properties
GITHUB_USER=seu_usuario
GITHUB_TOKEN=seu_token
```

Também é necessário configurar o `.npmrc` na raiz do projeto:

```ini
@shapeddev:registry=https://npm.pkg.github.com
always-auth=true
//npm.pkg.github.com/:_authToken=${NODE_AUTH_TOKEN}
```

Para definir a variável `NODE_AUTH_TOKEN`, siga as instruções abaixo:

- **No ambiente local**, execute:

  ```sh
  export NODE_AUTH_TOKEN=seu_token_aqui
  ```

  Ou, no Windows (PowerShell):

  ```sh
  $env:NODE_AUTH_TOKEN="seu_token_aqui"
  ```

### Instale as dependências

```sh
npm install
```

ou

```sh
yarn install
```

### Rodando o App no Android

```sh
npx react-native run-android
```

ou

```sh
npm run android
```

### Rodando o App no iOS

Antes de rodar no iOS, instale as dependências do CocoaPods:

```sh
cd ios
pod install
cd ..
```

Agora, execute:

```sh
npx react-native run-ios
```

ou

```sh
npm run ios
```

Pronto! Agora você pode testar o app de exemplo do **Shaped React Native Plugin**. 🚀

