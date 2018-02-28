//
//  CommentsManager.swift
//  senfonico
//
//  Created by omer kantar on 28.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

// MARK: - Singleton bir class yaratarak local user comment yazinca save etmesi saglanacak 🦄

class CommentsManager {
    
    static var sharedInstance = CommentsManager()
    
    var commentsOfPostModels = [Int: PostModel]()
    
    func postModel(postId: Int) -> PostModel? {
        return commentsOfPostModels[postId]
    }

    func save(model: PostModel) {
        let id = model.postId
        commentsOfPostModels[id] = model
    }
}
