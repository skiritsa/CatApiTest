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
    
    var viewModel: TableViewViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewModel = ViewModel()
        title = "All Bread"
        
        setTableView()
        setLoader()
     
        viewModel?.getAllBreed {
            self.tableView.reloadData()
            self.loader.stopAnimating()
            self.tableView.separatorStyle = .singleLine
        }
    }
}

extension BreedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreedCell.reuseId) as? BreedCell
        guard let viewModel = viewModel, let breedCell = cell else { return UITableViewCell()}
        breedCell.viewModel = viewModel.cellViewModel(for: indexPath)
        return breedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel,
            let detailViewModel = viewModel.viewModelForSelectedRow(at: indexPath) else { return }
            let detailVC = DetailViewController(viewModel: detailViewModel)
            navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension BreedViewController {
    
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
