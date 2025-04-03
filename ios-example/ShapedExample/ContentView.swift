//
//  ContentView.swift
//  ShapedExample
//
//  Created by Cesar Nalio on 19/03/25.
//

import SwiftUI
import ShapedPluginCamera

struct ContentView: View {
        
    @ObservedObject
    var shapedPlugin: ShapedPluginCamera

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Button {
                    shapedPlugin.startPoseSound()
                } label: {
                    Text("Iniciar som")
                }
                
                Spacer()
                
                Button {
                    shapedPlugin.stopPoseSound()
                } label: {
                    Text("Parar som")
                }
                
                Spacer()

            }
            .frame(height: 20)
            
            HStack {
                if let isFrontalValidation = shapedPlugin.onChangeFrontalValidation {
                    Text("\(isFrontalValidation ? "Pose Frontal" : "Pose Lateral")")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.system(size: 38))
                        .frame(height: 30)
                }
            }
            .frame(height: 20)

            HStack {
                if let onErrorsPose = shapedPlugin.onErrorsPose {
                    let errorCode = onErrorsPose.first
                    let error = ErrorCode().message()[errorCode ?? ""]
                    Text("Erros de pose: \(error ?? "")")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.system(size: 32))
                        .frame(height: 20)
                }
            }
            .frame(height: 20)

            HStack {
                if let deviceLevel = shapedPlugin.onDeviceLevel {
                    Text("Nível do dispositivo é valido: \(deviceLevel.isValid ? "Sim" : "Não. X = ") \(deviceLevel.x), Y = \(deviceLevel.y)")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.system(size: 32))
                        .frame(height: 20)
                }
            }
            .frame(height: 20)

            HStack {
                Text("Contagem regressiva: \((shapedPlugin.onCountdown != nil) ? String(shapedPlugin.onCountdown ?? 0) : "")")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .font(.system(size: 32))
                    .frame(height: 20)
                
            }
            .frame(height: 20)

            HStack {
                shapedPlugin.cameraView()
            }
            .frame(alignment: .center)
            
            HStack {
                if let image = shapedPlugin.onImagesCaptured {
                    
                    if let frontalImage = image.frontalImage?.image {
                        let imageData = NSData(bytes: frontalImage.data.bytes, length: frontalImage.data.bytes.count)

                        if let fImage = UIImage(data: imageData as Data) {
                            VStack {
                                Image(uiImage: fImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                Text("\(frontalImage.width)x\(frontalImage.height)")
                            }
                        }
                    }
                    
                    if let sideImage = image.sideImage?.image {
                        let imageData = NSData(bytes: sideImage.data.bytes, length: sideImage.data.bytes.count)

                        if let sImage = UIImage(data: imageData as Data) {
                            VStack {
                                Image(uiImage: sImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                Text("\(sideImage.width)x\(sideImage.height)")
                            }
                        }
                    }
                    
                }
            }
            .frame(alignment: .center)

        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .padding()
        .onAppear() {
            shapedPlugin.setAudioPath(path: "customSound")
            shapedPlugin.copyAudioToPath(path: "customSound", fromBundle: "CustomSounds", fromAudioName: "audio_file", toAudioName: "face_not_detected_sound")
        }
    }
}

#Preview {
    ContentView(shapedPlugin: ShapedPluginCamera())
}

public class ErrorCode {
    public func message() -> Dictionary<String, String> {
        return [
            "faceNotDetected": "Caminhe para trás, enquadrando o corpo inteiro",
            "leftHandNotDetected": "Mão esquerda não está aparecendo na imagem",
            "rightHandNotDetected": "Mão direita não está aparecendo na imagem",
            "leftFootNotDetected": "Pé esquerdo não está aparecendo na imagem",
            "rightFootNotDetected": "Pé direito não está aparecendo na imagem",
            "angleNotDetected": "Ajuste sua postura",
            "armsBelow": "Levante os braços",
            "armsTop": "Abaixe os braços",
            "legsOpen": "Aproxime as pernas",
            "legsClosed": "Afaste as pernas",
            "rightArmTop": "Abaixe o braço direito",
            "rightArmBelow": "Levante o braço direito",
            "leftArmTop": "Abaixe o braço esquerdo",
            "leftArmBelow": "Levante o braço esquerdo",
            "verifyVolumeSetting": "Por favor verifique o volume do dispositivo",
            "personIsFar": "Aproxime-se da câmera",
            "deviceLevelInvalid": "Afaste o ângulo do seu device"
        ]
    }
}

extension Data {
    var bytes: [UInt8] {
        return [UInt8](self)
    }
}
