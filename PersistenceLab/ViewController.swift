//
//  ViewController.swift
//  PersistenceLab
//
//  Created by Matthew Ramos on 1/20/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit
import NetworkHelper

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
    }
    
    func getPicture() {
        PicturesAPIClient.fetchPictures { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Couldn't get images, \(appError)")
                }
            case .success(let data):
                self?.pictures = data
                
            }
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as? PictureCell else {
            fatalError("Error: Could not downcast to PictureCell, check cellforitem")
        }
        let picture = pictures[indexPath.row]
        cell.configureCell(picture: picture)
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
}

extension ViewController: UISearchBarDelegate {
    
}
