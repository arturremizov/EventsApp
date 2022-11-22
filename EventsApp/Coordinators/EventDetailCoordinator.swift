//
//  EventDetailCoordinator.swift
//  EventsApp
//
//  Created by Artur Remizov on 20.11.22.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventID: NSManagedObjectID
    var parentCoordinator: EventListCoordinator?
    var onUpdateEvent = {}
    
    init(navigationController: UINavigationController, eventID: NSManagedObjectID) {
        self.navigationController = navigationController
        self.eventID = eventID
    }
    
    func start() {
        let detailViewController: EventDetailViewController = .instantiate()
        let eventDetailViewModel = EventDetailViewModel(eventID: eventID)
        eventDetailViewModel.coordinator = self
        onUpdateEvent = { [weak self] in
            eventDetailViewModel.reload()
            self?.parentCoordinator?.onUpdateEvent()
        }
        detailViewController.viewModel = eventDetailViewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func onEditEvent(event: EventEntity) {
        let editEventCoordinator = EditEventCoordinator(navigationController: navigationController, event: event)
        editEventCoordinator.parentCoordinator = self
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
}

