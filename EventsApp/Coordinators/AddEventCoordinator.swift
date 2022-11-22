//
//  AddEventCoordinator.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import UIKit

final class AddEventCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    private var photoPickerCompletion: (UIImage) -> Void = { _ in }
    
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addEventViewController: AddEventViewController = AddEventViewController.instantiate()
        let modalNavigationController = UINavigationController(rootViewController: addEventViewController)
        let addEventViewModel = AddEventViewModel(cellBuilder: EventsCellBuilder())
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        navigationController.present(modalNavigationController, animated: true)
        self.modalNavigationController = modalNavigationController
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishSavingEvent() {
        navigationController.dismiss(animated: true)
        parentCoordinator?.onUpdateEvent()
    }
    
    func showPhotoPicker(_ completion: @escaping (UIImage) -> Void) {
        guard let modalNavigationController else { return }
        photoPickerCompletion = completion
        let photoPickerCoordinator = PhotoPickerCoordinator(navigationController: modalNavigationController, parrentCoordinator: self)
        photoPickerCoordinator.onFinishPicking = photoPickerCompletion
        childCoordinators.append(photoPickerCoordinator)
        photoPickerCoordinator.start()
    }
}
