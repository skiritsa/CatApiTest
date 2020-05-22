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
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let fetcher = NetworkDataFetcher()
    
    var allBreed: [BreedResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "All Bread"
        setTableView()
        
        fetcher.getBreed { (allBreedResponse) in
            guard let allBreedResponse = allBreedResponse else { return }
            self.allBreed = allBreedResponse
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
