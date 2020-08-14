//
//  DetailViewController.swift
//  CatApiTest
//
//  Created by Alex Kiritsa on 22.07.2020.
//  Copyright © 2020 Alex Kiritsa. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    private var viewModel: DetailViewModelType?
    
    convenience init(viewModel: DetailViewModelType) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        
        guard let viewModel = viewModel else { return }
        viewModel.getData { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func configTableView() {
        tableView.estimatedRowHeight = 10
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = ColorConstant.fourthColor
        
        tableView.register(DetailTextViewCell.self, forCellReuseIdentifier: DetailTextViewCell.reuseId)
        tableView.register(DetailDescriptionViewCell.self, forCellReuseIdentifier: DetailDescriptionViewCell.reuseId)
        tableView.register(DetailRatingViewCell.self, forCellReuseIdentifier: DetailRatingViewCell.reuseId)
        tableView.register(DetailImageViewCell.self, forCellReuseIdentifier: DetailImageViewCell.reuseId)
    }
}

extension DetailViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else { return UITableView.automaticDimension }
        if indexPath.row == 0 {
            return viewModel.imageRatio * UIScreen.main.bounds.width
        } else {
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell()}
        let item = viewModel.allCells[indexPath.row]
        
        switch item.type {
        case .descriptionBreedCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailDescriptionViewCell.reuseId, for: indexPath) as? DetailDescriptionViewCell {
                cell.viewModel = item
                return cell
            }
        case .textPropertyCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailTextViewCell.reuseId, for: indexPath) as? DetailTextViewCell {
                cell.viewModel = item
                return cell
            }
        case .ratingPropertyCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailRatingViewCell.reuseId, for: indexPath) as? DetailRatingViewCell {
                cell.viewModel = item
                return cell
            }
        case .imageViewCell:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageViewCell.reuseId, for: indexPath) as? DetailImageViewCell {
                cell.viewModel = item
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
