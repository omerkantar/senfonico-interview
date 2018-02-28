//
//  Comment.swift
//  senfonico
//
//  Created by omer kantar on 28.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class CommentModel: BaseModel {
    
    var postId: Int = 0
    var name: String?
    var email: String?
    var body: String?
    
    
    override func mapping(json: [String : Any]) {
        self.postId = (json["postId"] as? Int) ?? 0
        self.name = json["name"] as? String
        self.email = json["email"] as? String
        self.body = json["body"] as? String
    }
    
    static func me(body: String? = nil, postId: Int) -> CommentModel {
        let comment = CommentModel()
        comment.postId = postId
        comment.name = "me:"
        comment.body = body
        return comment
    }
}
