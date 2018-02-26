//
//  PhotosServiceManager.swift
//  senfonico
//
//  Created by omer kantar on 26.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit



class PhotosPaginationManager: NSObject {
    
    var allPhotos = [PhotoModel]()
    var perpage: Int = 30
    var page: Int = 0
    var text: String? = nil
    
    func clear() {
        allPhotos.removeAll()
        perpage = 30
        page = 0
        text = nil
    }
    
}
