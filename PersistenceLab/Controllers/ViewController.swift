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
    
    var pictures = [Picture]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPictures(query: "")
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = collectionView.indexPath(for: (sender as! PictureCell)) else {
            fatalError("Error: Check prepare for segue")
        }
        detailVC.picture = pictures[indexPath.row]
        
    }
    
    func getPictures(query: String) {
        PicturesAPIClient.fetchPictures(query: query) { [weak self] (result) in
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 10
        let maxWidth = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 3
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else {
            getPictures(query: "")
            return
        }
        getPictures(query: query)
    }
}
