//
//  EventsCellBuilder.swift
//  EventsApp
//
//  Created by Artur Remizov on 17.11.22.
//

import Foundation

struct EventsCellBuilder {
    
    func makeAddEventCellViewModel(_ type: AddEventCellViewModel.CellType,
                                   onCellUpdate: AddEventCellViewModel.Handler?) -> AddEventCellViewModel {
        switch type {
        case .text:
            return AddEventCellViewModel(title: "Name",
                                         subtitle: "",
                                         placeholder: "Add a name...",
                                         type: .text,
                                         onUpdate: onCellUpdate)
        case .date:
            return AddEventCellViewModel(title: "Date",
                                      subtitle: "",
                                      placeholder: "Select a date...",
                                      type: .date,
                                      onUpdate: onCellUpdate)
        case .image:
            return AddEventCellViewModel(title: "Background",
                                         subtitle: "",
                                         placeholder: "",
                                         type: .image,
                                         onUpdate: onCellUpdate)
        }
    }
}
