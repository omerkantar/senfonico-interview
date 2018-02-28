//
//  PostsViewModel.swift
//  senfonico
//
//  Created by omer kantar on 28.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PostsViewModel {

    var postCellVMs: [PostCellViewModel]?
    
    func build(response: ResponseModel) {
        if let list = response.object as? [[String: Any]] {
            self.postCellVMs = list.map({ (json) -> PostCellViewModel in
                let model = PostModel(json: json)
                return PostCellViewModel(model: model)
            })
        }
    }
}


