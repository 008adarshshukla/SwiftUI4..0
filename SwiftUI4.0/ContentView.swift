//
//  ContentView.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 26/11/22.
//

import SwiftUI

struct ContentView: View {
    let value = Locale.current.region?.identifier
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            if value != nil {
                Text(value!)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


