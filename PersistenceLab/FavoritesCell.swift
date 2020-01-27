//
//  FavoritesCell.swift
//  PersistenceLab
//
//  Created by Matthew Ramos on 1/26/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    @IBOutlet weak var favoritesImageView: UIImageView!
    @IBOutlet weak var uploaderLabel: UILabel!
    
     func configureCell(picture: Picture) {
            favoritesImageView.getImage(with: picture.largeImageURL) { [weak self] (result) in
                switch result {
                case .failure:
                    DispatchQueue.main.async {
                        self?.favoritesImageView.image = UIImage(systemName: "exclamationmark-triangle")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.favoritesImageView.image = image
                    }
                }
            }
        }
    }

