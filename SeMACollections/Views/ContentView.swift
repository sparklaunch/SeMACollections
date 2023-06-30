//
//  ContentView.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/06/30.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = false
    @EnvironmentObject private var collectionsManager: CollectionsManager
    var body: some View {
        ZStack {
            TabView {
                MainView()
                    .tabItem {
                        Label("Collections", systemImage: "building.columns")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
            }
            .task {
                do {
                    isLoading = true
                    try await collectionsManager.loadData()
                    isLoading = false
                } catch {
                    print(error.localizedDescription)
                }
            }
            if isLoading {
                ProgressView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CollectionsManager())
    }
}
