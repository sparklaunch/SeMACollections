//
//  PhotosManager.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/07/01.
//

import SwiftUI

class PhotosManager {
    static func saveToPhotosLibrary(with url: URL) async {
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            fatalError("Failed to download image.")
        }
        guard let uiImage = UIImage(data: data) else {
            fatalError("Failed to decode image.")
        }
        UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
    }
}
