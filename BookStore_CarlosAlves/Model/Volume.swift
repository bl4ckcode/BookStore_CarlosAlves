//
//  Volume.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 08/03/21.
//

import Foundation

class Volume: ObservableObject, Codable {
    let totalItems: Int?
    let items: [Book]?
    
    init() {
        totalItems = 0
        items = [Book]()
    }
    
    init(totalItems: Int?,
         items: [Book]?) {
        self.totalItems = totalItems
        self.items = items
    }
}
