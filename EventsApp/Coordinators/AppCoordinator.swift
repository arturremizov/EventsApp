//
//  AppCoordinator.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
    func childDidFinish(_ childCoordinator: Coordinator)
}

extension Coordinator {
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === childCoordinator ? true : false }) {
            childCoordinators.remove(at: index)
        }
    }
}

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        let eventListCoordinator = EventListCoordinator(navigationController: navigationController)
        childCoordinators.append(eventListCoordinator)
        eventListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
