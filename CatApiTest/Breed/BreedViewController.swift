//
//  BreedViewController.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 04.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class BreedViewController: UIViewController {

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorConstant.fourthColor
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    let fetcher = NetworkDataFetcher()
    
    var allBreed: [BreedResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "All Bread"
        setTableView()
        setLoader()
        
        fetcher.getBreed { (allBreedResponse) in
            guard let allBreedResponse = allBreedResponse else { return }
            self.allBreed = allBreedResponse
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loader.stopAnimating()
            }
        }
    }
    
    func setLoader() {
        view.addSubview(loader)
        
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loader.startAnimating()
    }
    
    func setTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BreedCell.self, forCellReuseIdentifier: BreedCell.reuseId)
    }
}

extension BreedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBreed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreedCell.reuseId) as! BreedCell
        
        let breed = allBreed[indexPath.row]
        cell.set(breed: breed)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BreedDetailViewController()
        vc.curentBreed = allBreed[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
