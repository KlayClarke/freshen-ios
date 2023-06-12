//
//  ContentView.swift
//  Freshen
//
//  Created by Klay Anthony Clarke on 6/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world")
            let _ = APICaller.instance.retrieveSalons()
        }
        .padding()
    }
}
