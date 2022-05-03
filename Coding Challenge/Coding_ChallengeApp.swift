//
//  Coding_ChallengeApp.swift
//  Coding Challenge
//
//  Created by Wattpad Cuong on 2022-04-28.
//

import SwiftUI

@main
struct Coding_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(storiesProvider:  MockStoriesProvider(isSuccess: false))
        }
    }
}
