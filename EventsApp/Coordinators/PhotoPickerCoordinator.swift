//
//  PhotoPickerCoordinator.swift
//  EventsApp
//
//  Created by Artur Remizov on 17.11.22.
//

import UIKit
import PhotosUI

final class PhotoPickerCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var parrentCoordinator: AddEventCoordinator
    
    init(navigationController: UINavigationController, parrentCoordinator: AddEventCoordinator) {
        self.navigationController = navigationController
        self.parrentCoordinator = parrentCoordinator
    }
    
    func start() {
        var pickerConfiguration = PHPickerConfiguration(photoLibrary: .shared())
        pickerConfiguration.selectionLimit = 1
        pickerConfiguration.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        let pickerViewController = PHPickerViewController(configuration: pickerConfiguration)
        pickerViewController.delegate = self
        
        navigationController.present(pickerViewController, animated: true)
    }
}

// MARK: - PHPickerViewControllerDelegate
extension PhotoPickerCoordinator: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let result = results.first else {
            self.parrentCoordinator.childDidFinish(childCoordinator: self)
            return
        }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
            guard let self else { return }
            
            DispatchQueue.main.async {
                guard let image = reading as? UIImage, error == nil else {
                    self.parrentCoordinator.childDidFinish(childCoordinator: self)
                    return
                }
                self.parrentCoordinator.didFinishPicking(image)
                self.parrentCoordinator.childDidFinish(childCoordinator: self)
            }
        }
    }
}
