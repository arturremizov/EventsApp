//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import Foundation

final class EventListViewModel {
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    var onUpdate = {}
    private(set) var cells: [EventListViewModel.Cell] = []
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func reload() {
        EventCellViewModel.imageCache.removeAllObjects()
        let events = coreDataManager.fetchEvents()
        cells = events.map {
            var eventCellViewModel = EventCellViewModel($0)
            if let coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
            return .event(eventCellViewModel)
        }
        onUpdate()
    }
    
    func didTapAddEventButton() {
        coordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int {
        cells.count
    }
    
    func cell(at indexPath: IndexPath) -> EventListViewModel.Cell {
        cells[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}
