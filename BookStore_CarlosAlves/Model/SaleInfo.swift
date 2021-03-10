//
//  SaleInfo.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 09/03/21.
//

import Foundation

struct SaleInfo: Codable {
    let buyLink: String?
    
    init() {
        buyLink = ""
    }
    
    init(buyLink: String?) {
        self.buyLink = buyLink
    }
}
