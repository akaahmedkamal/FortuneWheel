//
//  ContentView.swift
//  Shared
//
//  Created by Ahmed Kamal on 10/09/2021.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 1

    var body: some View {
        TabView {
            TextBasedFortuneWheelView()
                .tabItem {
                    Label("Text Based", systemImage: "textformat")
                }
                .tag(0)

            ImageBasedFortuneWheelView()
                .tabItem {
                    Label("Image Based", systemImage: "photo")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
