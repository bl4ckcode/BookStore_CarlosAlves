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
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            BooksView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
                saveContext()
            @unknown default:
                fatalError()
            }
        }
    }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SampleApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
