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
        playerController.player?.currentItem?.externalMetadata = makeExternalMetadata()
        present(playerController, animated: true){
            player.play()
        }
    }
    
    func makeExternalMetadata() -> [AVMetadataItem]{
        var metadata = [AVMetadataItem]()
        
        //build title item
        let titleItem = makeMetadataItem(.commonIdentifierTitle, value: "Improve your Debugging Skills")
        metadata.append(titleItem)
        
        //Buid Artwork Item
        if let image = UIImage(named: "debugging"), let pngData = image.pngData(){
            let artworkItem = makeMetadataItem(.commonIdentifierArtwork, value: pngData)
            metadata.append(artworkItem)
        }
        
        //Build description item
        let descItem = makeMetadataItem(.commonIdentifierDescription, value: """
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
"""
        )
        metadata.append(descItem)
        
        //build genre item
        let genreItem = makeMetadataItem(.quickTimeMetadataGenre, value: "Education")
        metadata.append(genreItem)
        
        return metadata
    }
    
    private func makeMetadataItem(_ identifier: AVMetadataIdentifier, value: Any) -> AVMetadataItem{
        let item = AVMutableMetadataItem()
        item.identifier = identifier
        item.value = value as? NSCopying & NSObjectProtocol
        item.extendedLanguageTag = "und"
        return item.copy() as! AVMetadataItem
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
