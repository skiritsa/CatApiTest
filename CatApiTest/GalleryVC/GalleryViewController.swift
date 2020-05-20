//
//  GalleryViewController.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 19.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class GalleryViewController: UICollectionViewController {
    
    var photos = [BreedImageResponse]()
    let fetcher = NetworkDataFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        
        if let layout = collectionView?.collectionViewLayout as? TableLayout {
          layout.delegate = self
        }
    }
    
    func set(breed: BreedResponse?) {
        fetcher.getImageUrl(breed) { (breedImageResponse) in
            guard let response = breedImageResponse else { return }
            
            self.photos = response
            self.collectionView.reloadData()
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
}

// MARK: - UICollectionViewDataSource
extension GalleryViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        
        cell.set(imageUrl: photos[indexPath.row].url)
        return cell
    }
}

extension GalleryViewController: TableLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
}
