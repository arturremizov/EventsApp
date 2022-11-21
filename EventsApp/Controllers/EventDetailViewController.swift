//
//  EventDetailViewController.swift
//  EventsApp
//
//  Created by Artur Remizov on 20.11.22.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var timeRemainingStackView: TimeRemainingStackView! {
        didSet {
            timeRemainingStackView.setup()
        }
    }
    
    var viewModel: EventDetailViewModel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] in
            guard let self else { return }
            self.backgroundImageView.image = self.viewModel.image
            if let timeRemainingViewModel = self.viewModel.timeRemainingViewModel {
                self.timeRemainingStackView.update(with:timeRemainingViewModel)
            }
        }
        
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
