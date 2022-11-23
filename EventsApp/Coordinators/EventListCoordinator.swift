//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import UIKit
import CoreData

final class EventListCoordinator: Coordinator, EventUpdatingCoordinator {
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var onUpdateEvent = {}
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListViewController: EventListViewController = EventListViewController.instantiate()
        let eventListViewModel = EventListViewModel()
        onUpdateEvent = eventListViewModel.reload
        eventListViewModel.coordinator = self
        eventListViewController.viewModel = eventListViewModel
        navigationController.setViewControllers([eventListViewController], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }

    func onSelect(_ id: NSManagedObjectID) {
        let eventDetailCoordinator = EventDetailCoordinator(navigationController: navigationController, eventID: id)
        eventDetailCoordinator.parentCoordinator = self
        childCoordinators.append(eventDetailCoordinator)
        eventDetailCoordinator.start()

    }
}
