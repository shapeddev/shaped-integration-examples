# Shaped Flutter Plugin App Example

Shaped Flutter Plugin App Example

## Como Rodar o App de Exemplo

Para rodar o app de exemplo, siga os passos abaixo:

### Clone o repositório

```sh
git clone https://github.com/shapeddev/shaped-integration-examples.git
```

### Navegue até a pasta do app de exemplo

```sh
cd flutter-example
```

### Configure as credenciais

No arquivo `android/local.properties`, adicione suas credenciais disponibilizadas pelo administrador para garantir que as dependências privadas sejam resolvidas corretamente:

```properties
GITHUB_USER=seu_usuario
GITHUB_TOKEN=seu_token
```

Para definir a variável `GITHUB_TOKEN`, siga as instruções abaixo:

- **No ambiente local**, execute:

  ```sh
  export GITHUB_TOKEN=seu_token_aqui
  ```

  Ou, no Windows (PowerShell):

  ```sh
  $env:GITHUB_TOKEN="seu_token_aqui"
  ```

### Instale as dependências

```sh
flutter pub get
```

### Rodando o App no Android

```sh
flutter run
```
Selecione um device Android


### Rodando o App no iOS

Antes de rodar no iOS, instale as dependências do CocoaPods:

```sh
cd ios
pod install
cd ..
```

Agora, execute:

```sh
flutter run
```

Selecione um device iOS


Pronto! Agora você pode testar o app de exemplo do **Shaped Flutter Plugin**. 🚀

