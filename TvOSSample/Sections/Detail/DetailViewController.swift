//
//  DetailViewController.swift
//  TvOSSample
//
//  Created by Luis Enrique Diaz Ramirez on 02/06/23.
//

import Foundation
import UIKit
import AVKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var similarTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        similarTableView.register(UINib(nibName: "VideosTableViewCell", bundle: nil), forCellReuseIdentifier: "VideosTableViewCell")
        similarTableView.estimatedRowHeight = 300
        similarTableView.rowHeight = UITableView.automaticDimension
        similarTableView.reloadData()
    }
    
    
    @IBAction func didClicOnPlayButton(_ sender: UIButton) {
        guard let path = Bundle.main.path(forResource: "Debugging", ofType: "mp4") else{
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        
        playerController.player = player
        playerController.player?.currentItem?.externalMetadata = Utils().makeExternalMetadata()
        present(playerController, animated: true){
            player.play()
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: VideosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "VideosTableViewCell", for: indexPath) as? VideosTableViewCell{
            cell.type = .latestVideos
            cell.latestVideos.removeFirst()
            cell.titleLabel.text = "You May Like"
            cell.videosCollectionViewHeightConstraint.constant = 200
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
