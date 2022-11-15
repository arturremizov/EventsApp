//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import UIKit

final class AddEventViewModel {
    
    var coordinator: AddEventCoordinator?
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
}
