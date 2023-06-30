//
//  CollectionsManager.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/06/30.
//

import SwiftUI

@MainActor class CollectionsManager: ObservableObject {
    @Published private var _collections: [Collection] = []
    @Published var count = 0
    var collections: [Collection] {
        get {
            _collections.sorted()
        }
        set {
            _collections = newValue
        }
    }
    private let apiKey = "49497a51466c696e33355546774f7a"
    private var endPoint: URL {
        let endPointString = "http://openapi.seoul.go.kr:8088/\(apiKey)/json/SemaPsgudInfoEngInfo/1/1000"
        return URL(string: endPointString)!
    }
    func loadData() async throws {
        do {
            let (data, _) = try await URLSession.shared.data(from: endPoint)
            let decodedData = try JSONDecoder().decode(CollectionsHeader.self, from: data)
            collections = decodedData.header.body
            count = decodedData.header.count
        } catch {
            print(error.localizedDescription)
        }
    }
    func searchedCollections(with searchText: String) -> [Collection] {
        if searchText.isEmpty {
            return collections
        } else {
            return collections.filter { collection in
                collection.koreanName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
