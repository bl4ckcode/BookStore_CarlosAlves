//
//  ImageView.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 09/03/21.
//

import SwiftUI
import Combine

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString: url)
    }

    var body: some View {
        Image(uiImage: imageLoader.image ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
    }
}
