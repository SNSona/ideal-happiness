//
//  Image.swift
//  GlowingCollage (iOS)
//
//  Created by Sona Sargsyan on 04.06.22.
//

import Foundation

// MARK: - ListElement

struct ImageData: Codable, Equatable, Hashable {
    var id: String
    var author: String
    var width: Int
    var height: Int
    var url: String
    var downloadURL: String

    private enum CodingKeys : String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadURL = "download_url"
    }
}

extension ImageData {
    static func fackData() -> ImageData {
        ImageData(
            id: "",
            author: "",
            width: 1,
            height: 1,
            url: "",
            downloadURL: ""
        )
    }
}

