//
//  ContentView.swift
//  Coding Challenge
//
//  Created by Wattpad Cuong on 2022-04-28.
//

import SwiftUI
//import DataLayer

struct ContentView: View {
    let storiesProvider: StoriesProviderInterface
    
    var body: some View {
        Text("Hello, world!")
            .padding().onAppear {
                Task {
                    await storiesProvider.fetchStories()
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(storiesProvider: StoriesProvider(apiProvider: DataService.shared))
    }
}
