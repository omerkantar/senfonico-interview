//
//  PhotosViewModel.swift
//  senfonico
//
//  Created by omer kantar on 26.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PhotosViewModel {

    var paginationManager = PhotosPaginationManager()
    var lastPageModel: PhotoPageModel?
    var canPageUp: Bool {
        if let page = lastPageModel {
            return page.canPageUp
        }
        return false
    }
    
    func refreshData() {
        paginationManager.clear()
        lastPageModel = nil
    }
    
    func loadedData(responseModel: ResponseModel) {
        
    }
    
}
