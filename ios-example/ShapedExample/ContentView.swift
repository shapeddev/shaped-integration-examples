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
                    Text("Start Sound")
                }
                
                Spacer()
                
                Button {
                    shapedPlugin.stopPoseSound()
                } label: {
                    Text("Stop Sound")
                }
                
                Spacer()
            }
            .frame(height: 20)
            
            HStack {
                if let onErrorsPose = shapedPlugin.onErrorsPose {
                    let errors = onErrorsPose.first
                    Text("Error: \(errors ?? "")")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.system(size: 60))
                        .frame(height: 20)
                }
            }
            .frame(height: 20)

            HStack {
                shapedPlugin.cameraView()
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
    }
}

#Preview {
    ContentView(shapedPlugin: ShapedPluginCamera())
}
