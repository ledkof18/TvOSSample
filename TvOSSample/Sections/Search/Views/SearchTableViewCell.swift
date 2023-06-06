//
//  SearchTableViewCell.swift
//  TvOSSample
//
//  Created by Luis Enrique Diaz Ramirez on 06/06/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        containerView.backgroundColor = UIColor.darkGray
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 10
        containerView.layer.borderColor = UIColor.clear.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ [weak self] in
            if self?.isFocused ?? false{
                self?.containerView?.layer.borderColor = UIColor.white.cgColor
            }else{
                self?.containerView?.layer.borderColor = UIColor.clear.cgColor
            }
        }, completion: nil)
    }


}
