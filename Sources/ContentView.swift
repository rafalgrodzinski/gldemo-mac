//
//  ContentView.swift
//  glDemo
//
//  Created by Rafal on 20/12/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var config = GLView.Config()

    var body: some View {
        HStack(spacing: 0) {
            GLViewWrapper(config: config)
                .background(Color.blue)
            ControlsView(config: $config)
                .background(Color.red)
        }
    }
}

private struct ControlsView: View {
    @Binding var config: GLView.Config

    var body: some View {
        EmptyView()
    }
}
