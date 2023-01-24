//
//  ContentView.swift
//  SwiftUIViewInspector
//
//  Created by Vid Tadel on 1/24/23.
//

import SwiftUI
import SwiftUIInspector

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
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
