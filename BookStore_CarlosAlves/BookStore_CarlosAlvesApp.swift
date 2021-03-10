//
//  BookStore_CarlosAlvesApp.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 08/03/21.
//

import SwiftUI
import CoreData

@main
struct BookStore_CarlosAlvesApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared


    var body: some Scene {
        WindowGroup {
            BooksView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
