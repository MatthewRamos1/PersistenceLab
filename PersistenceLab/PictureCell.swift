//
//  PictureCell.swift
//  PersistenceLab
//
//  Created by Matthew Ramos on 1/22/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit
import ImageKit

class PictureCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(picture: Picture) {
        imageView.getImage(with: picture.largeImageURL) { [weak self] (result) in
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
