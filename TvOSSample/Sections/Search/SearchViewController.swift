//
//  SearchViewController.swift
//  TvOSSample
//
//  Created by Luis Enrique Diaz Ramirez on 02/06/23.
//

import Foundation
import UIKit
import AVKit

class SearchViewController: UIViewController{
    
    @IBOutlet weak var detailTableView: UITableView!
    private var searchViewModel: SearchViewModel!
    var dataEmployees: [Character]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        callToViewModelForUIUpdate()
    }
    
    func setupTableView()
    {
        detailTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        detailTableView.estimatedRowHeight = 300
        detailTableView.rowHeight = UITableView.automaticDimension
    }
    
    func callToViewModelForUIUpdate(){
        self.searchViewModel = SearchViewModel(httpClient: ApiService())
        Task{
            try await searchViewModel.callFuncToGetEmpData()
        }
        
        self.searchViewModel.bindEmployeeViewModelToController = {
            self.updateData(data: self.searchViewModel.empData)
        }
    }
    
    func updateData(data: Characters){
        dataEmployees = data.results
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
        }
    }
    
    func playVideo(urlString: String) {
        let player = AVPlayer(url: URL(string: urlString)!)
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        playerController.player?.currentItem?.externalMetadata = Utils().makeExternalMetadata()
        present(playerController, animated: true){
            player.play()
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataEmployees?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell{
            cell.titleLabel.text = dataEmployees?[indexPath.row].name
            cell.searchImageView.downImage(urlString: dataEmployees?[indexPath.row].image, placeholder: "debugging")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.playVideo(urlString: "https://devstreaming-cdn.apple.com/videos/wwdc/2018/103zvtnsrnrijr/103/hls_vod_mvp.m3u8")
    }
}


