//
//  CoreDataManager.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventsApp")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try viewContext.existingObject(with: id) as? T
        } catch {
            print(error)
            return nil
        }
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            print(error)
            return []
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
}
