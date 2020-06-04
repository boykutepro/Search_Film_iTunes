//
//  Model.swift
//  Demo_SearchFilm_iTunes
//
//  Created by Thien Tung on 5/25/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import Foundation
import SwiftyJSON


class iTuneObject {
    var resultCount: Int
    var results: [Itune]?
    
    required init(json: JSON) {
        resultCount = json["resultCount"].intValue
        results = json["results"].arrayValue.map { Itune(json: $0)}
    }
}

class Itune: Codable {
    var filmName: String?
    var imageURL: String?
    var artistName: String?
    var trackPrice: Float?
    var country: String?
    var previewUrl: String?
    
    required init(json: JSON) {
        filmName = json["trackName"].stringValue
        imageURL = json["artworkUrl100"].stringValue
        artistName = json["artistName"].stringValue
        trackPrice = json["trackPrice"].floatValue
        country = json["country"].stringValue
        previewUrl = json["previewUrl"].stringValue
    }
}
