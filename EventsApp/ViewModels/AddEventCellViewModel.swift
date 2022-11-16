//
//  AddEventCellViewModel.swift
//  EventsApp
//
//  Created by Artur Remizov on 16.11.22.
//

import Foundation

final class AddEventCellViewModel {
    
    enum CellType {
        case text
        case date
        case image
    }
    
    let title: String
    private(set) var subtitle: String
    let placeholder: String
    let type: CellType
    
    private var onUpdate: () -> Void = {}
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    init(title: String,
         subtitle: String,
         placeholder: String,
         type: AddEventCellViewModel.CellType,
         onUpdate: @escaping () -> Void) {
        
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.type = type
        self.onUpdate = onUpdate
    }
    
    func update(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    func update(_ date: Date) {
        self.subtitle = dateFormatter.string(from: date)
        onUpdate()
    }
}


