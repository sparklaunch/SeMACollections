//
//  MainView.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/06/30.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var collectionsManager: CollectionsManager
    @State private var isLoading = false
    @State private var searchText = ""
    var body: some View {
        ZStack {
            NavigationView {
                List(collectionsManager.searchedCollections(with: searchText)) { collection in
                    NavigationLink {
                        CollectionDetailView(collection: collection)
                    } label: {
                        CollectionRow(collection: collection)
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .autocorrectionDisabled()
                .navigationTitle("Collections (\(collectionsManager.count))")
            }
            .navigationViewStyle(.stack)
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CollectionsManager())
    }
}
