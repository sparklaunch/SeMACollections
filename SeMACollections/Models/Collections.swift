//
//  Collections.swift
//  SeMACollections
//
//  Created by Jinwook Kim on 2023/06/30.
//

import SwiftUI

struct CollectionsHeader: Codable {
    enum CodingKeys: String, CodingKey {
        case header = "SemaPsgudInfoEngInfo"
    }
    let header: CollectionsBody
}

struct CollectionsBody: Codable {
    enum CodingKeys: String, CodingKey {
        case count = "list_total_count"
        case result = "RESULT"
        case body = "row"
    }
    let count: Int
    let result: CollectionsResult
    let body: [Collection]
}

struct CollectionsResult: Codable {
    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MESSAGE"
    }
    let code: String
    let message: String
}

struct Collection: Identifiable, Codable {
    static let example = Collection(classification: "뉴미디어", yearCollected: .now, koreanName: "하나코와 김치오빠 외 연속재생", englishName: "Hanaco and Mr. Kimchi etc. playback", standard: "29분34초", yearMade: "2017", materialAndTechnique: "Three-channel video, color, sound", description: "", authorName: "Yun Choi", imageURL: "N/A", thumbnailURL: "N/A")
    enum CodingKeys: String, CodingKey {
        case classification = "prdct_cl_nm"
        case yearCollected = "manage_no_year"
        case koreanName = "prdct_nm_korean"
        case englishName = "prdct_nm_eng"
        case standard = "prdct_stndrd"
        case yearMade = "mnfct_year"
        case materialAndTechnique = "matrl_technic"
        case description = "prdct_detail"
        case authorName = "writr_nm"
        case imageURL = "main_image"
        case thumbnailURL = "thumb_image"
    }
    var id: Int {
        var hasher = Hasher()
        hasher.combine(koreanName)
        hasher.combine(standard)
        hasher.combine(imageURL)
        return hasher.finalize()
    }
    let classification: String
    let yearCollected: Date
    let koreanName: String
    let englishName: String
    let standard: String
    let yearMade: String
    let materialAndTechnique: String
    let description: String
    let authorName: String
    let imageURL: String
    let thumbnailURL: String
}

extension CollectionsHeader {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        header = try container.decode(CollectionsBody.self, forKey: .header)
    }
}

extension CollectionsBody {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        result = try container.decode(CollectionsResult.self, forKey: .result)
        body = try container.decode([Collection].self, forKey: .body)
    }
}

extension Collection {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        classification = try container.decode(String.self, forKey: .classification)
        yearCollected = try container.decode(Date.self, forKey: .yearCollected)
        koreanName = try container.decode(String.self, forKey: .koreanName)
        englishName = try container.decode(String.self, forKey: .englishName)
        standard = try container.decode(String.self, forKey: .standard)
        yearMade = try container.decode(String.self, forKey: .yearMade)
        materialAndTechnique = try container.decode(String.self, forKey: .materialAndTechnique)
        description = try container.decode(String.self, forKey: .description)
        authorName = try container.decode(String.self, forKey: .authorName)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
    }
}

extension Collection: Comparable {
    static func <(lhs: Collection, rhs: Collection) -> Bool {
        lhs.koreanName < rhs.koreanName
    }
}
