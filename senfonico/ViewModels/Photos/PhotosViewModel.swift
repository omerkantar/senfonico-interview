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
    var cellVMs = [MediaCellViewModel]()
    var lastPageModel: MediaPageModel?
    var canPageUp: Bool {
        if let page = lastPageModel {
            return page.resultCount > cellVMs.count
        }
        return true
    }
    
    var isFirst: Bool {
        return lastPageModel == nil
    }
    
    func refreshData() {
        cellVMs.removeAll()
        paginationManager.clear()
        lastPageModel = nil
    }
    
    fileprivate func pageUp() {
        paginationManager.pageUp()
    }
    
    func loadedData(responseModel: ResponseModel, type: MediaPageModel.MediaType = .image) {
        self.lastPageModel = MediaPageModel(json: responseModel.json, type: type)
        if let list = self.lastPageModel?.medias {
            paginationManager.allPhotos += list
            let newCellVMs = list.map({ (model) -> MediaCellViewModel in
                return MediaCellViewModel(photo: model)
            })
            self.cellVMs += newCellVMs
            pageUp()
        }
    }
    
}
