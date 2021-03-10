//
//  BookStoreViewModel.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 08/03/21.
//

import Foundation
import Combine

class BookStoreViewModel: ObservableObject {
    @Published var books: [Book] = [Book]()
    @Published var isLoadingPage = false
    
    private var currentPage = 0
    private var canLoadMorePages = true

    init() {
        loadMoreContent()
    }

    func loadMoreContentIfNeeded(currentItem item: Book?) {
        guard let item = item else {
                loadMoreContent()
            return
        }

        let thresholdIndex = books.index(books.endIndex, offsetBy: -5)
        if books.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadMoreContent()
        }
    }

    private func loadMoreContent() {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }

        isLoadingPage = true
        
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=ios&startIndex=\(currentPage)&maxResults=20")!
            URLSession.shared.dataTaskPublisher(for: url)
              .map(\.data)
              .decode(type: Volume.self, decoder: JSONDecoder())
              .receive(on: DispatchQueue.main)
              .handleEvents(receiveOutput: { response in
                self.canLoadMorePages = response.items?.count ?? [Book]().count <= response.totalItems ?? 0
                self.isLoadingPage = false
                self.currentPage += 1
              })
              .map({ response in
                return self.books + (response.items ?? [Book]())
              })
              .catch({ _ in Just(self.books) })
              .assign(to: &$books)
    }
}
