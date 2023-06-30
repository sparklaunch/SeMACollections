//
//  CollectionDetailView.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/07/01.
//

import SwiftUI

struct CollectionDetailView: View {
    @EnvironmentObject private var favoritesManager: FavoritesManager
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
                    HStack {
                        VStack(alignment: .leading) {
                            Text(collection.koreanName)
                                .font(.largeTitle.bold())
                            Text(collection.englishName)
                                .font(.title3)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        if favoritesManager.has(collection) {
                            Button {
                                favoritesManager.remove(collection)
                            } label: {
                                Image(systemName: "star.fill")
                                    .imageScale(.large)
                            }
                        } else {
                            Button {
                                favoritesManager.add(collection)
                            } label: {
                                Image(systemName: "star")
                                    .imageScale(.large)
                            }
                        }
                    }
                    Text("**Author**: \(collection.authorName).")
                    Text("**Classification**: \(collection.classification).")
                    Text("**Year Collected**: \(collection.yearCollected.formatted(.dateTime.year())).")
                    Text("**Standard**: \(collection.standard).")
                    Text("**Year Made**: \(collection.yearMade).")
                    if !collection.materialAndTechnique.isEmpty {
                        Text("**Material and Technique**: \(collection.materialAndTechnique).")
                    }
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
            .environmentObject(FavoritesManager())
    }
}
