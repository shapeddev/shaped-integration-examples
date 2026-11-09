# Shaped Expo Plugin App Example

Shaped Expo Plugin App Example

## Como Rodar o App de Exemplo

Para rodar o app de exemplo, siga os passos abaixo:

### Clone o repositório e entre na pasta do projeto

```sh
git clone https://github.com/shapeddev/shaped-mobile-react-native.git
cd shaped-mobile-react-native
```

### Navegue até a pasta do app de exemplo

```sh
cd expo-example
```

### Configure as credenciais

Crie um arquivo `.env.local` na pasta `expo-example` com as credenciais disponibilizadas pelo administrador, para garantir que as dependências privadas sejam resolvidas corretamente. Esse arquivo já está no `.gitignore`:

```ini
GITHUB_USER=seu_usuario
GITHUB_TOKEN=seu_token
NODE_AUTH_TOKEN=seu_token
```

Também é necessário configurar o `.npmrc` na raiz do projeto:

```ini
@shapeddev:registry=https://npm.pkg.github.com
always-auth=true
//npm.pkg.github.com/:_authToken=${NODE_AUTH_TOKEN}
```

Os comandos `npx expo` carregam o `.env.local` automaticamente. Para rodar `npm install` ou `pod install` diretamente, carregue as variáveis antes:

```sh
set -a; source .env.local; set +a
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
npx expo run:android
```

ou

```sh
npm run android
```

### Rodando o App no iOS

```sh
npx expo run:ios
```

ou

```sh
npm run ios
```

Os comandos acima geram as pastas `android` e `ios` quando elas ainda não existem. Se você já tinha essas pastas de um SDK anterior, gere novamente antes de rodar:

```sh
npx expo prebuild --clean
```

### Rodando em um dispositivo físico

Adicione `--device` para escolher o aparelho conectado:

```sh
npx expo run:android --device
```

```sh
npx expo run:ios --device
```

Pronto! Agora você pode testar o app de exemplo do **Shaped Expo Plugin**. 🚀

