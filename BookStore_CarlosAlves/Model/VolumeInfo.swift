//
//  VolumeInfo.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 08/03/21.
//

import Foundation

class VolumeInfo: Codable, ObservableObject {
    let title: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let imageLinks: ImageLink?
    let saleInfo: SaleInfo?
    
    init() {
        self.title = ""
        self.authors = [String]()
        self.publisher = ""
        self.publishedDate = ""
        self.description = ""
        self.imageLinks = ImageLink()
        self.saleInfo = SaleInfo()
    }
    
    init(title: String?,
         authors: [String]?,
         publisher: String?,
         publishedDate: String?,
         description: String?,
         imageLinks: ImageLink?,
         saleInfo: SaleInfo?) {
        self.title = title
        self.authors = authors
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.description = description
        self.imageLinks = imageLinks
        self.saleInfo = saleInfo
    }
}
