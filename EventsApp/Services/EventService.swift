//
//  EventService.swift
//  EventsApp
//
//  Created by Artur Remizov on 23.11.22.
//

import UIKit
import CoreData


struct EventInputData {
    let name: String
    let date: Date
    let image: UIImage
}

enum EventAction {
    case add
    case update(EventEntity)
}

protocol EventServiceProtocol {
    
    func perform(_ action: EventAction, data: EventInputData)
    func getEvent(_ id: NSManagedObjectID) -> EventEntity?
    func getEvents() -> [EventEntity]
}

final class EventService: EventServiceProtocol {
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    func perform(_ action: EventAction, data: EventInputData) {
        var event: EventEntity
        switch action {
        case .add:
            event = EventEntity(context: coreDataManager.viewContext)
        case .update(let eventToUpdate):
            event = eventToUpdate
        }
        
        event.name = data.name
        let resizedImage = data.image.sameAspectRatio(newHeight: 250)
        event.image = resizedImage.pngData()
        event.date = data.date
        
        coreDataManager.save()
    }
    
    func getEvent(_ id: NSManagedObjectID) -> EventEntity? {
        coreDataManager.get(id)
    }
    
    func getEvents() -> [EventEntity] {
        return coreDataManager.getAll()
    }
}
