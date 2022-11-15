//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    var coordinator: EventListCoordinator?
    
    func didTapAddEventButton() {
        coordinator?.startAddEvent()
    }
}
