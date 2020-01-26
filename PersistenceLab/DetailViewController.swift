//
//  DetailViewController.swift
//  PersistenceLab
//
//  Created by Matthew Ramos on 1/21/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var picture: Picture?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    func updateUI() {
        guard let detailVCpicture = picture else {
            fatalError("Error: Couldn't access Picture data, check prepare for segue")
        }
        imageView.getImage(with: detailVCpicture.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "exclamationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }

}
