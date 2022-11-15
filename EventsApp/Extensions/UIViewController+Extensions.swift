//
//  UIViewController+Extensions.swift
//  EventsApp
//
//  Created by Artur Remizov on 15.11.22.
//

import UIKit

extension UIViewController {
    
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: String(describing: T.self)) as! T
        return controller
    }
}
