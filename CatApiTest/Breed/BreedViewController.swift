//
//  BreedViewController.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 04.05.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class BreedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let fetcher = NetworkDataFetcher()
    
    var allBreed: [BreedResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(BreedCell.self, forCellReuseIdentifier: BreedCell.reuseId)
        
        fetcher.getBreed { (allBreedResponse) in
            guard let allBreedResponse = allBreedResponse else { return }
            self.allBreed = allBreedResponse
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
        guard let vc = UIStoryboard(name: "BreedDetail", bundle: nil).instantiateViewController(identifier: "BreedDetail") as? BreedDetailViewController else { return }
        vc.curentBreed = allBreed[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
