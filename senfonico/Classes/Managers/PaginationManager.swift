//
//  PhotosServiceManager.swift
//  senfonico
//
//  Created by omer kantar on 26.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PaginationManager {
    
    var allPhotos = [PhotoModel]()
    var perpage: Int = 30
    var text: String?
    var page: Int = 1
    
    func clear() -> Void {
        perpage = 30
        page = 1
        allPhotos.removeAll()

    }
    
    func pageUp() -> Void {
        page += 1
    }
    
    var requestTarget: RequestTarget {
        return RequestTarget.coffee
    }
}


class PhotosPaginationManager: PaginationManager {
    
    override var requestTarget: RequestTarget {
        return RequestTarget.photos(key: text, perpage: perpage, page: page)
    }
}

class 

