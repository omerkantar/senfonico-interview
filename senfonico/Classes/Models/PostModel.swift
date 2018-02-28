//
//  PostModel.swift
//  senfonico
//
//  Created by omer kantar on 28.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PostModel: BaseModel {

    var userId: Int = 0
    var title: String?
    var body: String?
    var comments = [CommentModel]()
    var postId: Int = 0

    override func mapping(json: [String : Any]) {
        self.postId = (json["id"] as? Int) ?? 0
        self.userId = (json["userId"] as? Int) ?? 0
        self.title = json["title"] as? String
        self.body = json["body"] as? String

    }
    
}
