//
//  EventDetailCoordinator.swift
//  EventsApp
//
//  Created by Artur Remizov on 20.11.22.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventID: NSManagedObjectID
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController, eventID: NSManagedObjectID) {
        self.navigationController = navigationController
        self.eventID = eventID
    }
    
    func start() {
        let detailViewController: EventDetailViewController = .instantiate()
        let eventDetailViewModel = EventDetailViewModel(eventID: eventID)
        eventDetailViewModel.coordinator = self
        detailViewController.viewModel = eventDetailViewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(childCoordinator: self)
    }
    
    deinit {
        print("DEINIT: ", String(describing: Self.self))
    }
}

