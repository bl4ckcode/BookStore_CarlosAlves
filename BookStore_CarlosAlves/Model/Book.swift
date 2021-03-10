//
//  Book.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 08/03/21.
//

import Foundation

class Book: Codable, Identifiable, ObservableObject {
    let id: String?
    let volumeInfo: VolumeInfo?
    
    init() {
        id = ""
        volumeInfo = VolumeInfo()
    }
    
    init(id: String?,
         volumeInfo: VolumeInfo?) {
        self.id = id
        self.volumeInfo = volumeInfo
    }
}
