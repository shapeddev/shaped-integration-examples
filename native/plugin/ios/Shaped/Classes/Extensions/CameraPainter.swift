import SwiftUI
import ShapedSDK

struct CustomPathView: Identifiable {
    var id: Int {
        self.name
    }
    var name: Int
    var path: StrokeShapeView<Path, Color, EmptyView>?
}

extension View {
    
    func calculatePoseLandmarks(poseState: CustomPose, imageSize: CGSize, canvasImageSize: CGSize) -> [[Any]] {
        let aspectRatio: CGFloat = 3.0 / 4.0
        let canvasWidth = canvasImageSize.width
        let canvasHeight = canvasWidth / aspectRatio

        let hRatio = imageSize.width == 0 ? 1.0 : canvasWidth / imageSize.width
        let vRatio = imageSize.height == 0 ? 1.0 : canvasHeight / imageSize.height

        let landmarksByType = Dictionary(uniqueKeysWithValues: poseState.landmarks.map { ($0.type, $0) })

        var points = [[Any]]()

        let _: [()] = poseState.connectionsColor.map({ connection in
            if let pointA = landmarksByType[connection.a.toInt()].map({
                CGPoint(
                    x: min(max($0.position.x * hRatio, 0), canvasWidth),
                    y: min(max($0.position.y * vRatio, 0), canvasHeight)
                )
            }), let pointB = landmarksByType[connection.b.toInt()].map({
                CGPoint(
                    x: min(max($0.position.x * hRatio, 0), canvasWidth),
                    y: min(max($0.position.y * vRatio, 0), canvasHeight)
                )
            }) {
                let color = connection.valid ? Color.green : Color.red
                
                points.append([pointA, pointB, color])
                
            }
        })
        
        return points
    }
    
    func createCustomPaths(points: [[Any]]) -> [CustomPathView] {
        var paths = [CustomPathView]()

        for index in 0..<points.count {
            let pointA = points[index][0] as? CGPoint ?? CGPoint.zero
            let pointB = points[index][1] as? CGPoint ?? CGPoint.zero
            let color = points[index][2] as? Color ?? .red

            let pathLine = Path { path in
                path.move(to: pointA)
                path.addLine(to: pointB)
                // path.addEllipse(in: CGRect(x: pointA.x - 8, y: pointA.y - 8, width: 16, height: 16))
                // path.addEllipse(in: CGRect(x: pointB.x - 8, y: pointB.y - 8, width: 16, height: 16))
            }.stroke(color, lineWidth: 5)
            
            paths.append(CustomPathView(name: index, path: pathLine))
        }
        
        return paths
    }

    func createCustomMarkers(points: [[Any]]) -> [CustomPathView] {
        var markers = [CustomPathView]()

        for index in 0..<points.count {
            let pointA = points[index][0] as? CGPoint ?? CGPoint.zero
            let pointB = points[index][1] as? CGPoint ?? CGPoint.zero
            let color = Color.black

            let pathLine = Path { path in
                path.move(to: pointA)
                path.addEllipse(in: CGRect(x: pointA.x - 8, y: pointA.y - 8, width: 16, height: 16))
                path.addEllipse(in: CGRect(x: pointB.x - 8, y: pointB.y - 8, width: 16, height: 16))
            }.stroke(color, lineWidth: 5)
            
            markers.append(CustomPathView(name: index, path: pathLine))
        }
        
        return markers
    }

    func cameraPainter(poseState: CustomPose, imageSize: CGSize) -> some View {
        var startOverlay: some View {
            GeometryReader { proxy in
                let points = calculatePoseLandmarks(poseState: poseState, imageSize: imageSize, canvasImageSize: proxy.size)
                let paths = createCustomPaths(points: points)
                
                ForEach(paths, id: \.name) { line in
                    line.path
                }
            }
        }

        var markerOverlay: some View {
            GeometryReader { proxy in
                let points = calculatePoseLandmarks(poseState: poseState, imageSize: imageSize, canvasImageSize: proxy.size)
                let markers = createCustomMarkers(points: points)
                
                ForEach(markers, id: \.name) { marker in
                    marker.path
                }
            }
        }

        return self.overlay(startOverlay.overlay(markerOverlay), alignment: .topLeading)
    }
    
}

