import SwiftUI
import ShapedSDK
import AVFoundation
import AVFAudio
import Combine

public struct ShapedPluginSettings {
    var timerDurationInSeconds: Int?
    var accelerometerXRange: ClosedRange<Int>?
    var accelerometerYRange: ClosedRange<Int>?
    var minCameraRes: CGSize?
    var maxCameraRes: CGSize?
    
    public init(
        timerDurationInSeconds: Int? = nil,
        accelerometerXRange: ClosedRange<Int>? = nil,
        accelerometerYRange: ClosedRange<Int>? = nil,
        minCameraRes: CGSize? = nil,
        maxCameraRes: CGSize? = nil
    ) {
        self.timerDurationInSeconds = timerDurationInSeconds
        self.accelerometerXRange = accelerometerXRange
        self.accelerometerYRange = accelerometerYRange
        self.minCameraRes = minCameraRes
        self.maxCameraRes = maxCameraRes
    }
}

public class ShapedPluginCamera: ObservableObject {
    
    @ObservedObject
    public var bodyDetection: SwiftBodyDetection
    
    @Published
    public private(set) var onImagesCaptured: OrientationImages? = nil

    @Published
    public private(set) var onErrorsPose: [String]? = []

    @Published
    public private(set) var onCountdown: Int? = nil

    @Published
    public private(set) var onDeviceLevel: LevelDetail? = nil

    @Published
    public private(set) var onChangeFrontalValidation: Bool? = true

    @Published
    public private(set) var poseStateResult: PoseDetectionResult? = nil

    public var cancellables = Set<AnyCancellable>()
    
    private var shapedPluginSettings: ShapedPluginSettings?
    private var showAlert = true
    private var isLoading = false
    
    public init(
        swiftBodyDetection: SwiftBodyDetection = SwiftBodyDetection(),
        shapedPluginSettings: ShapedPluginSettings? = nil
    ) {
        self.bodyDetection = swiftBodyDetection
        self.shapedPluginSettings = shapedPluginSettings
        
        if let settings = shapedPluginSettings {
            bodyDetection.setSettings(
                timerDurationInSeconds: settings.timerDurationInSeconds,
                accelerometerXRange: settings.accelerometerXRange,
                accelerometerYRange: settings.accelerometerYRange,
                minCameraRes: settings.minCameraRes,
                maxCameraRes: settings.maxCameraRes
            )
        }
        
        bindDetection()
        enablePoseDetection()
        levelControlEnabled()
        handleCameraPermission()
        startPoseSound()
    }
    
    private func handleCameraPermission() {
        showAlert = true
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            showAlert = false
            startCameraStreaming()
        } else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    self.showAlert = false
                    self.startCameraStreaming()
                } else {
                    self.showAlert = true
                }
            })
        }
        
    }
    
    @MainActor
    private func bindDetection() {
        bodyDetection.$poseState.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] poseState in
                self?.handlePose(poseState)
            }).store(in: &cancellables)
    }
    
    private func handlePose(_ poseResult: PoseDetectionResult?) {
        guard let pose = poseResult, !isLoading else { return }
        
        poseStateResult = pose
        onErrorsPose = pose.errors
        onCountdown = pose.countdown
        onDeviceLevel = pose.deviceLevel
        
        let isValid = pose.isValid
        let shouldAdvanceToNextPhoto = pose.shouldAdvanceToNextPhoto

        if isValid {
            isLoading = true
            disableSidePoseDetection()
            stopCameraStreaming()
            onImagesCaptured = pose.images
            isLoading = false
        } else if shouldAdvanceToNextPhoto {
            isLoading = true
            onChangeFrontalValidation = false
            enableSidePoseDetection()
            isLoading = false
        }
    }

    public func setAudioPath(path: String = "audio") {
        bodyDetection.assetsManager.createDirectory(path)
        bodyDetection.setAudioPath(path)
    }
    
    public func cleanAudioPath(path: String = "audio") {
        bodyDetection.assetsManager.clearAllFilesFromDirectory(path)
    }
    
    public func copyAudioToPath(path: String, fromBundle: String, fromAudioName: String, toAudioName: SoundFileName) {
        if let sourceURL = bodyDetection.assetsManager.file(name: fromAudioName, extention: "mp3", bundle: fromBundle) {
            bodyDetection.assetsManager.copyFileToDocuments(sourceURL: sourceURL, nameForFile: "\(path)/\(toAudioName.rawValue)")
        }
    }
    
    public func enablePoseDetection() {
        bodyDetection.poseDetectionEnabled = true
    }
    
    public func disablePoseDetection() {
        bodyDetection.poseDetectionEnabled = false
    }
    
    public func enableSidePoseDetection() {
        bodyDetection.updateSidePoseDetectionEnabled(sidePoseDetectionEnabled: true)
    }
    
    public func disableSidePoseDetection() {
        bodyDetection.updateSidePoseDetectionEnabled(sidePoseDetectionEnabled: false)
    }
    
    public func startLevelControl() {
        bodyDetection.startLevelControl()
    }
    
    public func stopLevelControl() {
        bodyDetection.stopLevelControl()
    }
    
    public func levelControlEnabled() {
        bodyDetection.levelControlEnabled = true
    }
    
    public func levelControlDisabled() {
        bodyDetection.levelControlEnabled = false
    }
    
    public func startPoseSound() {
        bodyDetection.startPoseSound()
    }
    
    public func stopPoseSound() {
        bodyDetection.stopPoseSound()
    }
    
    public func startCameraStreaming() {
        do {
            try bodyDetection.startCameraStream()
        } catch {
            print(error)
        }
    }
    
    public func stopCameraStreaming() {
        bodyDetection.stopCameraStream()
    }
        
    @MainActor
    public func cameraView() -> some View {
        HStack {
            if !showAlert {
                if let image = bodyDetection.image,
                   let uiImage = UIImage(data: image.data) {
                    VStack {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cameraPainter(
                                poseState: poseStateResult?.pose ?? CustomPose(),
                                imageSize: uiImage.size
                            )
                    }
                }
            } else {
                VStack {
                }.alert(isPresented: .constant(true)) {
                    Alert(
                        title: Text("Permissão necessária"),
                        message: Text("Para utilizar o aplicativo é necessário conceder permissão a sua câmera! \n Vá para as configurações do sistema e ative a permissão."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }

        }
    }

}
