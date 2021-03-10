//
//  ImageLink.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 08/03/21.
//

import Foundation

struct ImageLink: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
    
    init() {
        smallThumbnail = ""
        thumbnail = ""
    }
    
    init(smallThumbnail: String?,
         thumbnail: String?) {
        self.smallThumbnail = smallThumbnail
        self.thumbnail = thumbnail
    }
}
