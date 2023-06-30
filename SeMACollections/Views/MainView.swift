//
//  MainView.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/06/30.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var collectionsManager: CollectionsManager
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
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CollectionsManager())
    }
}
