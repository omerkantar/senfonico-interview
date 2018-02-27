//
//  VideoTableViewCell.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        guard let imgView = imgView else {
            return
        }
        // image view loaded its found // 
        var scale: CGFloat = 1.0
        var alpha: CGFloat = 1.0
        var color: UIColor = .clear
        
        if highlighted {
            scale = 0.98
            alpha = 0.8
            color = .groupTableViewBackground
        }
        UIView.animate(withDuration: 0.25) {
            imgView.transform = CGAffineTransform(scaleX: scale, y: scale)
            imgView.alpha = alpha
            self.backgroundColor = color
        }
    }
    
    
    override func build(viewModel: BaseCellViewModel) {
        guard let vm = viewModel as? MediaCellViewModel else {
            return
        }
        imgView.image(url: vm.imageURL, placeholder: #imageLiteral(resourceName: "placeholder_mountain"))
    }
}
