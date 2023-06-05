//
//  ToolsCollectionViewCell.swift
//  TvOSSample
//
//  Created by Luis Enrique Diaz Ramirez on 02/06/23.
//

import UIKit

class ToolsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.cornerRadius = 20
        posterImageView.clipsToBounds = true
        posterImageView.layer.borderWidth = 10
        posterImageView.layer.borderColor = UIColor.clear.cgColor
    }
}
