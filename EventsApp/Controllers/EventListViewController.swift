//
//  EventListViewController.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import UIKit

class EventListViewController: UIViewController, StoryboardInstantiable {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(image: plusImage,
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapRightBarButton))
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func didTapRightBarButton() {
        
    }
}
