//
//  UIImageView+TvOSUIImageView.swift
//  TvOSSample
//
//  Created by Luis Enrique Diaz Ramirez on 06/06/23.
//

import Foundation
import SDWebImage

extension UIImageView {
    func downImage(urlString: String?, placeholder: String? = "", contentMode: UIView.ContentMode = .scaleAspectFill) {
        let placeholderImage     = UIImage(named: placeholder!)
        self.layer.masksToBounds = true
        self.contentMode         = contentMode
        self.image               = placeholderImage
        
        guard let link = urlString, let url = URL(string: link) else {
            return
        }
        
        self.sd_imageTransition = .fade
        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: .continueInBackground, completed: nil)
    }
}
