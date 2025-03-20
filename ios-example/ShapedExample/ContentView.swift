//
//  ContentView.swift
//  ShapedExample
//
//  Created by Cesar Nalio on 19/03/25.
//

import SwiftUI
import ShapedPluginCamera

struct ContentView: View {
        
    var body: some View {
        let _ = print(ShapedPluginCamera().onErrorsPose)

        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text(ShapedPluginCamera().onErrorsPose.first ?? "")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
