//
//  FavoritesView.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/06/30.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favoritesManager: FavoritesManager
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            List {
                ForEach(favoritesManager.searchedFavorites(with: searchText)) { favorite in
                    NavigationLink {
                        CollectionDetailView(collection: favorite)
                    } label: {
                        CollectionRow(collection: favorite)
                    }
                }
                .onDelete(perform: favoritesManager.delete)
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .autocorrectionDisabled()
            .navigationTitle("Favorites (\(favoritesManager.searchedFavorites(with: searchText).count))")
        }
        .navigationViewStyle(.stack)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoritesManager())
    }
}
