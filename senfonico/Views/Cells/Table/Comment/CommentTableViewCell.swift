//
//  CommentTableViewCell.swift
//  senfonico
//
//  Created by omer kantar on 28.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.backgroundColor = UIColor.dirtyWhite
        containerView.layer.cornerRadius = 3.0
        containerView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}

// MARK: - Build
extension CommentTableViewCell {
    override func build(viewModel: BaseCellViewModel) {
        guard let vm = viewModel as? CommentCellViewModel else {
            return
        }
        if let name = vm.model.name {
            nameLabel.text = name + ":"
        }
        bodyLabel.text = vm.model.body
    }
}
