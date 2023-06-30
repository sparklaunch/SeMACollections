//
//  FavoritesManager.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/07/01.
//

import SwiftUI

@MainActor class FavoritesManager: ObservableObject {
    @Published private var _favorites: [Collection] = []
    private var targetURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("Favorites")
    }
    var favorites: [Collection] {
        get {
            _favorites.sorted()
        }
        set {
            _favorites = newValue
        }
    }
    func searchedFavorites(with searchText: String) -> [Collection] {
        if searchText.isEmpty {
            return favorites
        } else {
            return favorites.filter { favorite in
                favorite.koreanName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    init() {
        loadData()
    }
    func loadData() {
        if let data = try? Data(contentsOf: targetURL) {
            guard let decodedData = try? JSONDecoder().decode([Collection].self, from: data) else {
                fatalError("Failed to decode data.")
            }
            favorites = decodedData
        } else {
            favorites = []
        }
    }
    func has(_ collection: Collection) -> Bool {
        favorites.contains(collection)
    }
    func add(_ collection: Collection) {
        favorites.append(collection)
        saveData()
    }
    func remove(_ collection: Collection) {
        if let index = favorites.firstIndex(of: collection) {
            favorites.remove(at: index)
            saveData()
        }
    }
    func saveData() {
        guard let encodedData = try? JSONEncoder().encode(favorites) else {
            fatalError("Failed to encode data.")
        }
        do {
            try encodedData.write(to: targetURL, options: [.atomic, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    func delete(at offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
        saveData()
    }
}
