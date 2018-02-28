//
//  PhotoCollectionViewCell.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        imageView.backgroundColor = UIColor.groupTableViewBackground
    }
    
    override var isHighlighted: Bool {
        didSet {
            var alpha: CGFloat = 1.0
            var scale: CGFloat = 1.0
            if isHighlighted {
                alpha = 0.5
                scale = 0.88
            }
            
            UIView.animate(withDuration: 0.2) {
                self.imageView.alpha = alpha
                self.imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            
        }
    }
    
    override func build(viewModel: BaseCellViewModel) {
        guard let vm = viewModel as? MediaCellViewModel else {
            return
        }
        imageView.image = nil
        imageView.image(url: vm.imageURL, placeholder: #imageLiteral(resourceName: "placeholder_mountain"))
    }

}
