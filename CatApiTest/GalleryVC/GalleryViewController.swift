//
//  GalleryViewController.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 19.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class GalleryViewController: UICollectionViewController {
    
    let currentBreed: Bool!
    var rowLayoutHidden: Bool = true
    
    var photos = [BreedImageResponse]()
    let fetcher = NetworkDataFetcher()
    
    var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var button = UIBarButtonItem(image: UIImage(named: "switch"), style: .plain, target: self, action: #selector(switchLayout))
    
    init(forBreed: Bool) {
        currentBreed = forBreed
        let layout = TableLayout()
        super.init(collectionViewLayout: layout)
        layout.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = ColorConstant.firstColor
        collectionView.backgroundColor = ColorConstant.fourthColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView!.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        
        getAllPhoto()
        
        if currentBreed  {
        collectionView.refreshControl = nil
        } else {
            collectionView.refreshControl = refreshControl
        }
    }
    
    func set(breed: BreedResponse?) {
        fetcher.getImageUrl(breed) { (breedImageResponse) in
            guard let response = breedImageResponse else { return }
            
            self.photos = response
            self.collectionView.reloadData()
        }
    }
    
    func getAllPhoto() {
        if currentBreed == false {
            fetcher.getAllImageUrl { (breedImageResponse) in
                guard let response = breedImageResponse else { return }
                self.photos = response
                self.collectionView.reloadData()
                self.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc func refresh() {
        getAllPhoto()
    }
    
    @objc func switchLayout() {
        if rowLayoutHidden {
            let layout = RowLayout()
            layout.delegate = self
            collectionView.setCollectionViewLayout(layout, animated: true)
            rowLayoutHidden = false
        } else {
            let layout = TableLayout()
            layout.delegate = self
            collectionView.setCollectionViewLayout(layout, animated: true)
            rowLayoutHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let currentPhoto = photos[indexPath.row].url
            let fullVc = FullPhotoViewController()
            fullVc.imageView.set(imageURL: currentPhoto)
            self.navigationController?.pushViewController(fullVc, animated: true)
    }
}

extension GalleryViewController: TableLayoutDelegate, RowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = photos[indexPath.row].width
        let height = photos[indexPath.row].height
        return CGSize(width: width, height: height)
    }
}
