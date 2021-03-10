//
//  BooksListView.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 08/03/21.
//

import SwiftUI
import Combine
import UIKit

struct BooksListView: View {
    @ObservedObject var volume = Volume()
    
    var body: some View {
        List(volume.items ?? [Book]()) { item in
            NavigationLink (destination: BookDetailView(book: item)) {
                HStack (alignment: .center) {
                    ImageView(withURL: item.volumeInfo?.imageLinks?.smallThumbnail ?? "")
                    
                    if let title = item.volumeInfo?.title {
                        Text(title)
                            .font(.caption)
                            .bold()
                    }
                    
                    //Image(star)
                }
            }
        }
    }
}

struct BooksStateView: View {
    @ObservedObject var viewModel = BookStoreViewModel()
    
    var body: some View {
        switch viewModel.state {
        case .ready:
            return AnyView(EmptyView())
        case .loading(_):
            return AnyView(ProgressView())
        case .loaded:
            return AnyView(
                VStack (alignment: .center) {
                    BooksListView(volume: viewModel.volume)
                }
            )
        case .error(let error):
            return AnyView(
                VStack(spacing: 10) {
                    Text(error.localizedDescription)
                        .frame(maxWidth: 300)
                    Button("Retry") {
                        viewModel.getiOSVolumes()
                    }
                }
                .padding()
                .background(Color.yellow)
            )
        }
    }
}

struct BooksView: View {
    @ObservedObject var viewModel = BookStoreViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 5.0)
            }
            .overlay(BooksStateView(viewModel: viewModel))
        }
        .onAppear(perform: viewModel.getiOSVolumes)
    }
}

struct BooksListView_Previews: PreviewProvider {
    static var previews: some View {
        BooksListView()
    }
}
