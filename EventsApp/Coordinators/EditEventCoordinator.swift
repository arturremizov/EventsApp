//
//  EditEventCoordinator.swift
//  EventsApp
//
//  Created by Artur Remizov on 22.11.22.
//

import UIKit

final class EditEventCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private var photoPickerCompletion: (UIImage) -> Void = { _ in }
    private let event: EventEntity
    
    var parentCoordinator: EventDetailCoordinator?
    
    init(navigationController: UINavigationController, event: EventEntity) {
        self.navigationController = navigationController
        self.event = event
    }
    
    func start() {
        let editEventViewController: EditEventViewController = EditEventViewController.instantiate()
        let editEventViewModel = EditEventViewModel(event: event, cellBuilder: EventsCellBuilder())
        editEventViewModel.coordinator = self
        editEventViewController.viewModel = editEventViewModel
        navigationController.pushViewController(editEventViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishUpdatingEvent() {
        parentCoordinator?.onUpdateEvent()
        navigationController.popViewController(animated: true)
    }
    
    func showPhotoPicker(_ completion: @escaping (UIImage) -> Void) {
        photoPickerCompletion = completion
        let photoPickerCoordinator = PhotoPickerCoordinator(navigationController: navigationController, parrentCoordinator: self)
        photoPickerCoordinator.onFinishPicking = photoPickerCompletion
        childCoordinators.append(photoPickerCoordinator)
        photoPickerCoordinator.start()
    }
}

