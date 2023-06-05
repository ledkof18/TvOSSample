//
//  HomeViewController.swift
//  TvOSSample
//
//  Created by Luis Enrique Diaz Ramirez on 02/06/23.
//

import Foundation
import UIKit

enum CellType: Int, CaseIterable {
    case carousel
    case latestVideos
    case classified
    case tools
}

class HomeViewController: UIViewController{
    
    @IBOutlet weak var homeDataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        homeDataTableView.delegate = self
        homeDataTableView.dataSource = self
    }
    
    
    func setupTableView()
    {
        homeDataTableView.register(UINib(nibName: "VideosTableViewCell", bundle: nil), forCellReuseIdentifier: "VideosTableViewCell")
        homeDataTableView.estimatedRowHeight = 300
        homeDataTableView.rowHeight = UITableView.automaticDimension
        homeDataTableView.reloadData()
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: VideosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideosTableViewCell", for: indexPath) as? VideosTableViewCell, let cellType = CellType(rawValue: indexPath.row){
            cell.type = cellType
            switch cellType {
            case .carousel:
                cell.titleLabel.isHidden = true
                cell.videosCollectionViewHeightConstraint.constant = 540
            case .latestVideos:
                cell.titleLabel.text = "Latest by iCode"
                cell.videosCollectionViewHeightConstraint.constant = 360
                cell.delegate = self
            case .classified:
                cell.titleLabel.text = "Classified"
                cell.videosCollectionViewHeightConstraint.constant = 360
            case .tools:
                cell.titleLabel.text = "Useful Tools"
                cell.videosCollectionViewHeightConstraint.constant = 300
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension HomeViewController: VideosCollectionViewCellDelegate{
    func didClicOnItem() {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            self.present(detailVC, animated: true)
        }
    }
}
