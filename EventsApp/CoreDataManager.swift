//
//  CoreDataManager.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import CoreData
import UIKit

final class CoreDataManager {
    
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
    
    func saveEvent(name: String, date: Date, image: UIImage) {
        let event = EventEntity(context: viewContext)
        event.name = name
        event.image = image.pngData()
        event.date = date
        save()
    }
    
    func fetchEvents() -> [EventEntity] {
        let entityName = String(describing: EventEntity.self)
        let fetchRequest = NSFetchRequest<EventEntity>(entityName: entityName)
        do {
            let events = try viewContext.fetch(fetchRequest)
            return events
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
