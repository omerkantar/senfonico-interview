//
//  CommentsViewModel.swift
//  senfonico
//
//  Created by omer kantar on 28.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class CommentsViewModel: NSObject {

    var cellVMs: [CommentCellViewModel]?
    
    func build(responseModel: ResponseModel, postModel: PostModel) {
        if let list = responseModel.object as? [[String: Any]] {
            postModel.comments.removeAll()
            self.cellVMs = list.map({ (json) -> CommentCellViewModel in
                let model = CommentModel(json: json)
                postModel.comments.append(model)
                return CommentCellViewModel(model: model)
            })
        }
        CommentsManager.sharedInstance.save(model: postModel)
    }
    
    func build(postModel: PostModel) {
        self.cellVMs = postModel.comments.map({ (model) -> CommentCellViewModel in
            return CommentCellViewModel(model: model)
        })
    }
}
