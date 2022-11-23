//
//  EditEventViewModel.swift
//  EventsApp
//
//  Created by Artur Remizov on 22.11.22.
//

import UIKit

final class EditEventViewModel {
    
    enum Cell {
        case titleSubtitle(AddEventCellViewModel)
    }
    
    weak var coordinator: EditEventCoordinator?
    
    let title = "Edit"
    var onUpdate: (() -> Void)? = {}
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    private var nameCellViewModel: AddEventCellViewModel?
    private var dateCellViewModel: AddEventCellViewModel?
    private var backgroundCellViewModel: AddEventCellViewModel?
    private let cellBuilder: EventsCellBuilder
    private let eventService: EventServiceProtocol
    private let event: EventEntity
    
    lazy var dateFormater: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    init(event: EventEntity,
         cellBuilder: EventsCellBuilder,
         eventService: EventServiceProtocol = EventService()) {
        
        self.event = event
        self.cellBuilder = cellBuilder
        self.eventService = eventService
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
        let eventInputData = EventInputData(name: name, date: date, image: image)
        eventService.perform(.update(event), data: eventInputData)
        coordinator?.didFinishUpdatingEvent()
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

private extension EditEventViewModel {
    
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
        
        
        guard
            let name = event.name,
            let date = event.date,
            let imageData = event.image, let image = UIImage(data: imageData)
        else { return }
        
        nameCellViewModel.update(name)
        dateCellViewModel.update(date)
        backgroundCellViewModel.update(image)
    }
}

