//
//  EventCellViewModel.swift
//  EventsApp
//
//  Created by Artur Remizov on 18.11.22.
//

import UIKit
import CoreData

struct EventCellViewModel {
    
    let date = Date()
    
    private static let imageCache = NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    private var cacheKey: String {
        event.objectID.description
    }

    var timeRemainingStrings: [String] {
        guard let eventDate = event.date else { return [] }
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String? {
        guard let eventDate = event.date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyy"
        return dateFormatter.string(from: eventDate)
    }
    
    var eventName: String? {
        event.name
    }

    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard
            let eventDate = event.date,
            let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",")
        else { return nil }
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts, mode: .cell)
    }
    
    var onSelect: (NSManagedObjectID) -> Void = { _ in }
    
    private let event: EventEntity
    init(_ event: EventEntity) {
        self.event = event
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = event.image, let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
                Self.imageCache.setObject(image, forKey: cacheKey as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func didSelect() {
        onSelect(event.objectID)
    }
}
