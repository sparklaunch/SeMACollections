//
//  SeMACollectionsApp.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/06/30.
//

import SwiftUI

@main
struct SeMACollectionsApp: App {
    @StateObject private var collectionsManager = CollectionsManager()
    @StateObject private var favoritesManager = FavoritesManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(collectionsManager)
                .environmentObject(favoritesManager)
        }
    }
}
