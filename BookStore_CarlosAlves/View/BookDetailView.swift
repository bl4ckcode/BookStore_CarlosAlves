//
//  BookDetailView.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 09/03/21.
//

import SwiftUI
import Combine
import UIKit

struct BookDetailView: View {
    @ObservedObject var book = Book()

    @Environment(\.openURL) var openURL
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Favorite.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Favorite.bookId, ascending: true),
        ]
    ) var favorites: FetchedResults<Favorite>
    
    var body: some View {
        VStack (alignment: .center ){
            if let title = book.volumeInfo?.title {
                Text(title)
                    .font(.caption)
                    .bold()
                    .padding()
            }
        
            ImageView(withURL: book.volumeInfo?.imageLinks?.thumbnail ?? "")
            
            if let publisher = book.volumeInfo?.publisher {
                Text(publisher)
                    .font(.body)
            }
            
            if let publishedDate = book.volumeInfo?.publishedDate {
                Text(publishedDate)
                    .font(.body)
            }
            
            if let authors = book.volumeInfo?.authors, authors.count > 0 {
                Text(authors.joined(separator: ", "))
                    .font(.body)
                    .padding()
            }
            
            if let buyLink = book.volumeInfo?.saleInfo?.buyLink {
                Button("Buy this book") {
                    openURL(URL(string: buyLink)!)
                }
            }
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
