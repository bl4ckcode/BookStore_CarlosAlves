//
//  State.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 08/03/21.
//

import Combine
import SwiftUI

enum StateView {
    case ready
    case loading(Cancellable)
    case loaded
    case error(Error)
}
