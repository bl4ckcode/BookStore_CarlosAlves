//
//  PersistenceController.swift
//  BookStore_CarlosAlves
//
//  Created by Carlos Alves on 09/03/21.
//

import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    static var preview: PersistenceController = {
        return PersistenceController(inMemory: true)
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Favorite")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
