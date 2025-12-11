import 'package:flutter/material.dart';
import 'package:flutter_example/provider/errors_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String setNoErrorsMessage() {
  return "Mantenha a posição!";
}

Map<String, String> setErrorMessages() {
  return {
    "faceNotDetected": "Caminhe para trás, enquadrando o corpo inteiro",
    "leftHandNotDetected": "Mão esquerda não está aparecendo na imagem",
    "rightHandNotDetected": "Mão direita não está aparecendo na imagem",
    "leftFootNotDetected": "Pé esquerdo não está aparecendo na imagem",
    "rightFootNotDetected": "Pé direito não está aparecendo na imagem",
    "angleNotDetected": "Ajuste sua postura",
    "armsBelow": "Levente os braços",
    "armsTop": "Abaixe os braços",
    "legsOpen": "Aproxime as pernas",
    "legsClosed": "Afaste as pernas",
    "rightArmTop": "Abaixe o braço direito",
    "rightArmBelow": "Levante o braço direito",
    "leftArmTop": "Abaixe o braço esquerdo",
    "leftArmBelow": "Levante o braço esquerdo",
    "verifyVolumeSetting": "Por favor verifique o volume do dispositivo",
    "personIsFar": "Aproxime-se da câmera",
    "deviceLevelInvalid": "Ajuste o nível do celular, evitando inclinações",
  };
}

String noErrorsMessage = setNoErrorsMessage();
Map<String, String> errorMessages = setErrorMessages();

class CaptureSdkErrors extends ConsumerStatefulWidget {
  const CaptureSdkErrors({super.key});

  @override
  CaptureSdkErrorsState createState() => CaptureSdkErrorsState();
}

class CaptureSdkErrorsState extends ConsumerState<CaptureSdkErrors> {
  List<String>? errorList;
  Color? messageBackground;

  @override
  Widget build(BuildContext context) {
    String? messageError;

    final errors = ref.watch(errorsProvider.notifier).get();
    final errorList = errors.errorList;

    if (errorList != null && errorList.isNotEmpty) {
      var key = errorList.first;
      messageError = errorMessages.containsKey(key) ? errorMessages[key] : null;
      messageBackground = Theme.of(context).colorScheme.error;
    } else {
      messageBackground = Theme.of(context).colorScheme.primary;
      messageError = noErrorsMessage;
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: messageError != null
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: messageBackground,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  messageError,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            )
          : SizedBox(height: 96),
    );
  }
}
