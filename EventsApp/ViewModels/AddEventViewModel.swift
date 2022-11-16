//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import UIKit

final class AddEventViewModel {
    
    enum Cell {
        case titleSubtitle(AddEventCellViewModel)
    }
    
    var coordinator: AddEventCoordinator?
    
    let title = "Add"
    var onUpdate: () -> Void = {}
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(
                AddEventCellViewModel(title: "Name",
                                      subtitle: "",
                                      placeholder: "Add a name...",
                                      type: .text,
                                      onUpdate: onUpdate)
            ),
            .titleSubtitle(
                AddEventCellViewModel(title: "Date",
                                      subtitle: "",
                                      placeholder: "Select a date...",
                                      type: .date,
                                      onUpdate: onUpdate)
            ),
            .titleSubtitle(
                AddEventCellViewModel(title: "Background",
                                      subtitle: "",
                                      placeholder: "",
                                      type: .image,
                                      onUpdate: onUpdate)
            ),
        ]
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    func numberOfRows() -> Int {
        cells.count
    }
    
    func cell(for indexPath: IndexPath) -> AddEventViewModel.Cell {
        cells[indexPath.row]
    }
    
    func didTapDone() {
        
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
}
