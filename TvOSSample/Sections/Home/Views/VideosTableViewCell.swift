//
//  VideosTableViewCell.swift
//  TvOSSample
//
//  Created by Luis Enrique Diaz Ramirez on 02/06/23.
//

import UIKit

protocol VideosCollectionViewCellDelegate: AnyObject {
    func didClicOnItem()
}

class VideosTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var videosCollectionViewHeightConstraint: NSLayoutConstraint!
    
    var type: CellType = .latestVideos
    weak var delegate: VideosCollectionViewCellDelegate?
    
    var latestVideos = ["debugging", "lazyView", "appleSignIn", "inheritance", "copyOnWrite", "methodDispatch"]
    var carouselVideos = ["tvOS_development", "iCode_Banner_Small"]
    var classifiedVideos = ["Interviews", "Swift UI", "Core Concepts", "DSA"]
    var toolsVideos = ["simsim", "instruments", "pusher"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        registerNibs()
    }
    
    func registerNibs(){
        videoCollectionView.register(UINib(nibName: "VideosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideosCollectionViewCell")
        videoCollectionView.register(UINib(nibName: "ClassifiedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ClassifiedCollectionViewCell")
        videoCollectionView.register(UINib(nibName: "ToolsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ToolsCollectionViewCell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension VideosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type{
        case .carousel:
            return carouselVideos.count
        case .latestVideos:
            return latestVideos.count
        case .classified:
            return classifiedVideos.count
        case .tools:
            return toolsVideos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type{
        case .carousel:
            if let cell: VideosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as? VideosCollectionViewCell{
                cell.type = type
                cell.posterImageView.image = UIImage(named: carouselVideos[indexPath.row])
                cell.posterImageView.contentMode = .scaleAspectFill
                return cell
            }
            return UICollectionViewCell()
        case .latestVideos:
            if let cell: VideosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as? VideosCollectionViewCell{
                cell.type = type
                cell.posterImageView.image = UIImage(named: latestVideos[indexPath.row])
                cell.posterImageView.contentMode = .scaleAspectFill
                return cell
            }
            return UICollectionViewCell()
        case .classified:
            if let cell: ClassifiedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassifiedCollectionViewCell", for: indexPath) as? ClassifiedCollectionViewCell{
                cell.configure(text: classifiedVideos[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        case .tools:
            if let cell: ToolsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToolsCollectionViewCell", for: indexPath) as? ToolsCollectionViewCell{
                cell.posterImageView.image = UIImage(named: toolsVideos[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate{
            delegate.didClicOnItem()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch type{
        case .carousel:
            return CGSize(width: collectionView.frame.size.width - 180, height: collectionView.frame.size.height)
        case .latestVideos, .tools:
            return CGSize(width: (16/9) * collectionView.frame.size.height, height: collectionView.frame.size.height)
        case .classified:
            return CGSize(width: 360, height: 360)
        }
    }
}
