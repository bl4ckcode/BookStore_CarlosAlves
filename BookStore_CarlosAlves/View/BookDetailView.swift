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
    @Environment(\.openURL) var openURL
    @ObservedObject var book = Book()
    
    var body: some View {
        NavigationView {
            VStack {
                ImageView(withURL: book.volumeInfo?.imageLinks?.thumbnail ?? "")
                
                if let title = book.volumeInfo?.title {
                    Text(title)
                        .font(.caption)
                        .bold()
                }
                
                if let publisher = book.volumeInfo?.publisher {
                    Text(publisher)
                        .font(.body)
                }
                
                if let publishedDate = book.volumeInfo?.publishedDate {
                    Text(publishedDate)
                        .font(.body)
                }
                
                if let authors = book.volumeInfo?.authors, authors.count > 0 {
                    List(authors, id: \.self) { item in
                        Text(item)
                            .font(.body)
                    }
                }
                
                if let buyLink = book.volumeInfo?.saleInfo?.buyLink {
                    Button("Buy this book") {
                        openURL(URL(string: buyLink)!)
                    }
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
