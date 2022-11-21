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
    
    weak var coordinator: AddEventCoordinator?
    
    let title = "Add"
    var onUpdate: (() -> Void)? = {}
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    private var nameCellViewModel: AddEventCellViewModel?
    private var dateCellViewModel: AddEventCellViewModel?
    private var backgroundCellViewModel: AddEventCellViewModel?
    private let cellBuilder: EventsCellBuilder
    private let coreDataManager: CoreDataManager
    
    lazy var dateFormater: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    init(cellBuilder: EventsCellBuilder, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.cellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        setupCells()
        onUpdate?()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        cells.count
    }
    
    func cell(for indexPath: IndexPath) -> AddEventViewModel.Cell {
        cells[indexPath.row]
    }
    
    func didTapDone() {
        guard
            let name = nameCellViewModel?.subtitle,
            let dateString = dateCellViewModel?.subtitle,
            let date = dateFormater.date(from: dateString),
            let image = backgroundCellViewModel?.image
        else {
            return
        }
        coreDataManager.saveEvent(name: name, date: date, image: image)
        coordinator?.didFinishSavingEvent()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let addEventCellViewModel) where addEventCellViewModel.type == .image:
            coordinator?.showPhotoPicker { image in
                addEventCellViewModel.update(image)
            }
        default:
            break
        }
    }
}

private extension AddEventViewModel {
    
    func setupCells() {
        
        nameCellViewModel = cellBuilder.makeAddEventCellViewModel(.text, onCellUpdate: onUpdate)
        dateCellViewModel = cellBuilder.makeAddEventCellViewModel(.date, onCellUpdate: onUpdate)
        backgroundCellViewModel = cellBuilder.makeAddEventCellViewModel(.image, onCellUpdate: onUpdate)
        
        guard let nameCellViewModel, let dateCellViewModel, let backgroundCellViewModel else { return }
        
        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(backgroundCellViewModel)
        ]
    }
}
