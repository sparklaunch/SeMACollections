//
//  CollectionRow.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/06/30.
//

import SwiftUI

struct CollectionRow: View {
    let collection: Collection
    var body: some View {
        VStack(alignment: .leading) {
            Text(collection.koreanName)
            if !collection.englishName.isEmpty {
                Text(collection.englishName.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct CollectionRow_Previews: PreviewProvider {
    static var previews: some View {
        CollectionRow(collection: Collection.example)
    }
}
