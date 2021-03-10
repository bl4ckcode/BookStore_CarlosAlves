//
//  BooksListView.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 08/03/21.
//

import SwiftUI
import Combine
import UIKit
import CoreData

struct BooksView: View {
    @ObservedObject var viewModel = BookStoreViewModel()
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Favorite.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Favorite.bookId, ascending: true),
        ]
    ) var favorites: FetchedResults<Favorite>
    
    var body: some View {
        NavigationView {
            List(viewModel.books) { item in
                NavigationLink (destination: BookDetailView(book: item)) {
                    HStack (alignment: .center) {
                        ImageView(withURL: item.volumeInfo?.imageLinks?.smallThumbnail ?? "")
                        
                        if let title = item.volumeInfo?.title {
                            Text(title)
                                .font(.caption)
                                .bold()
                        }
                        
                        if favorites.contains { $0.bookId == item.id } {
                            Image("star_yellow")
                                .onTapGesture(perform: {
                                    item.objectWillChange.send()

                                    if let favorite = favorites.first(where: { $0.bookId == item.id }) {
                                        managedObjectContext.delete(favorite)
                                    }
                                })
                        } else {
                            Image("star")
                                .onTapGesture(perform: {
                                    item.objectWillChange.send()
                                    
                                    let favorite = Favorite(context: managedObjectContext)
                                    favorite.bookId = item.id
                                    PersistenceController.shared.save()
                                })
                        }
                    }
                    .onAppear { viewModel.loadMoreContentIfNeeded(currentItem: item) }
                }
                
                if viewModel.isLoadingPage {
                    ProgressView()
                }
            }
            .navigationBarTitle("iOS Books")
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        BooksView()
    }
}
