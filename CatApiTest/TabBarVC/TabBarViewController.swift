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

        tabBar.barTintColor = ColorConstant.firstColor
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = ColorConstant.secondColor

        let breedVC = BreedViewController()
        let viewModel = ViewModel()
        breedVC.viewModel = viewModel

        let breedItem = UITabBarItem()
        breedItem.title = "Breeds"
        breedItem.image = UIImage(named: "catPixel")
        breedItem.tag = 0
        let breedNav = UINavigationController(rootViewController: breedVC)
        breedNav.navigationBar.barTintColor = ColorConstant.firstColor
        breedNav.tabBarItem = breedItem

        let galleryVC = GalleryViewController(forBreed: false)
        let galleryItem = UITabBarItem()
        galleryItem.title = "Gallery"
        galleryItem.image = UIImage(named: "gallery")
        galleryItem.tag = 1
        let galleryNav = UINavigationController(rootViewController: galleryVC)
        galleryNav.navigationBar.barTintColor = ColorConstant.firstColor
        galleryNav.tabBarItem = galleryItem

        let breedQuizVC = BreedQuizViewController()

        //swiftlint:disable force_cast
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //swiftlint:enable force_cast
        
        let quizViewModel = BreedQuizViewModel(context: context)
        breedQuizVC.viewModel = quizViewModel
        let quizItem = UITabBarItem()
        quizItem.title = "Quiz"
        quizItem.image = UIImage(named: "quiz")
        quizItem.tag = 2
        let quizNav = UINavigationController(rootViewController: breedQuizVC)
        quizNav.navigationBar.barTintColor = ColorConstant.firstColor
        quizNav.tabBarItem = quizItem

        let tabBarLists = [breedNav, galleryNav, quizNav]

        viewControllers = tabBarLists
    }

}
