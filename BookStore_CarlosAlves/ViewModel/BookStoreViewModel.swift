//
//  BookStoreViewModel.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 08/03/21.
//

import Foundation
import Combine

class BookStoreViewModel: ObservableObject {
    @Published var volume: Volume = Volume()
    @Published var state = StateView.ready
    @Published var isLoadingPage = false
    
    private var currentPage = 0
    private var canLoadMorePages = true
        
    var getBooksTask: AnyPublisher<Volume, Error> {
        URLSession.shared.dataTaskPublisher(
            for: URL(string: "https://www.googleapis.com/books/v1/volumes?q=ios&startIndex=\(currentPage)&maxResults=20")!)
            .map { $0.data }
            .decode(type: Volume.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    init() {
        loadMoreContent()
    }

    func loadMoreContentIfNeeded(currentItem item: Book?) {
        guard let item = item else {
                loadMoreContent()
            return
        }

        let items = volume.items ?? [Book]()
        let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
        if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            loadMoreContent()
        }
    }

    private func loadMoreContent() {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }

        isLoadingPage = true
    }

    func getiOSVolumes() {
        self.state = .loading(self.getBooksTask.sink(

            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self.state = .error(error)
                }
            },

            receiveValue: { value in
                self.canLoadMorePages = value.items?.count ?? [Book]().count <= value.totalItems ?? 0
                self.isLoadingPage = false
                self.currentPage += 1
                
                self.state = .loaded
                self.volume = value
            }
        ))
    }
}
