//
//  ShapedExampleApp.swift
//  ShapedExample
//
//  Created by Cesar Nalio on 19/03/25.
//

import SwiftUI
import ShapedPluginCamera

@main
struct ShapedExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(shapedPlugin: ShapedPluginCamera())
        }
    }
}
