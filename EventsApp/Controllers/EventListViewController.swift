//
//  EventListViewController.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import UIKit

class EventListViewController: UIViewController {

    var viewModel: EventListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(image: plusImage,
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapAddEventButton))
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func didTapAddEventButton() {
        viewModel.didTapAddEventButton()
    }
}
