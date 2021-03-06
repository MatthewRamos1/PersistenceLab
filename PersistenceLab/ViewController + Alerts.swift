//
//  ViewController + Alerts.swift
//  PersistenceLab
//
//  Created by Matthew Ramos on 1/22/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
