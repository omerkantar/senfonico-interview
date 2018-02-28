//
//  CommentCellViewModel.swift
//  senfonico
//
//  Created by omer kantar on 28.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class CommentCellViewModel: BaseCellViewModel {

    var model: CommentModel
    
    init(model: CommentModel) {
        self.model = model
    }
}
