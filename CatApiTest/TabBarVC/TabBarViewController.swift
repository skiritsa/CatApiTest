//
//  TabBarViewController.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 21.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let breedVC = BreedViewController()
        let breedItem = UITabBarItem()
        breedItem.title = "Breeds"
        breedItem.image = UIImage(named: "catPixel")
        breedItem.tag = 0
        let breedNav = UINavigationController(rootViewController: breedVC)
        breedNav.tabBarItem = breedItem
        
        let galleryVC = GalleryViewController(forBreed: false)
        let galleryItem = UITabBarItem()
        galleryItem.title = "Gallery"
        galleryItem.image = UIImage(named: "gallery")
        galleryItem.tag = 1
        let galleryNav = UINavigationController(rootViewController: galleryVC)
        galleryNav.tabBarItem = galleryItem
        
        let tabBarLists = [breedNav, galleryNav]
        
        viewControllers = tabBarLists
    }

}
