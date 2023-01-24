//
//  ContentView.swift
//  SwiftUIViewInspector
//
//  Created by Vid Tadel on 1/24/23.
//

import SwiftUI
import SwiftUIViewInspector

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Tap!") {
                print("tap")
            }
        }
        .padding()
        .inspectable()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
