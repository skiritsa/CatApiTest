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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
}
