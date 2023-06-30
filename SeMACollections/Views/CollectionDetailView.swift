//
//  CollectionDetailView.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/07/01.
//

import SwiftUI

struct CollectionDetailView: View {
    let collection: Collection
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: collection.imageURL)!, scale: 1) { phase in
                    switch phase {
                        case .success(let image):
                            image
                                .resizable()
                        case .failure(let error):
                            Text(error.localizedDescription)
                        case .empty:
                            Text("Loading…")
                        default:
                            Text("Unknown case.")
                    }
                }
                .scaledToFit()
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading) {
                        Text(collection.koreanName)
                            .font(.largeTitle.bold())
                        Text(collection.englishName)
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    Text("**Author**: \(collection.authorName).")
                    Text("**Classification**: \(collection.classification).")
                    Text("**Year Collected**: \(collection.yearCollected.formatted(.dateTime.year())).")
                    Text("**Standard**: \(collection.standard).")
                    Text("**Year Made**: \(collection.yearMade).")
                    Text("**Material and Technique**: \(collection.materialAndTechnique).")
                    if !collection.description.isEmpty {
                        Text("**Description**: \(collection.description).")
                    }
                }
                .padding()
            }
            .padding(.bottom, 100)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionDetailView(collection: Collection.example)
    }
}
