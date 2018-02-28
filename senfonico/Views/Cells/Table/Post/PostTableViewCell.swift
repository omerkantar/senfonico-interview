//
//  PostTableViewCell.swift
//  senfonico
//
//  Created by omer kantar on 28.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

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
        
        var color = UIColor.dirtyWhite
        var scale: CGFloat = 1.0
        if highlighted {
            color = .groupTableViewBackground
            scale = 0.98
        }

        UIView.animate(withDuration: 0.23) {
            self.containerView.backgroundColor = color
            self.containerView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
}

// MARK: - Build
extension PostTableViewCell {
    override func build(viewModel: BaseCellViewModel) {
        guard let vm = viewModel as? PostCellViewModel else {
            return
        }
        titleLabel.text = vm.model.title
        bodyLabel.text = vm.model.body
    }
}
