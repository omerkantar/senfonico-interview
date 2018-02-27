//
//  MediasViewModel.swift
//  senfonico
//
//  Created by omer kantar on 26.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class MediasViewModel {
    
    var paginationManager: PaginationManager?
    var cellVMs = [MediaCellViewModel]()
    var lastPageModel: MediaPageModel?
    
    var isFirst: Bool {
        return lastPageModel == nil
    }
    
    var canPageUp: Bool {
        if let lastPageModel = lastPageModel {
            return lastPageModel.resultCount > cellVMs.count
        }
        return true
    }
    
    func refreshData() {
        cellVMs.removeAll()
        paginationManager?.clear()
        lastPageModel = nil
    }
    
    func pageUp() {
        paginationManager?.pageUp()
    }
    
    func mediaType() -> MediaPageModel.MediaType? {
        return nil
    }
    
    func loadedData(responseModel: ResponseModel) {
        guard let type = mediaType() else {
            return
        }
        
        self.lastPageModel = MediaPageModel(json: responseModel.json, type: type)
        if let list = self.lastPageModel?.medias {
            paginationManager?.allPhotos += list
            let newCellVMs = list.map({ (model) -> MediaCellViewModel in
                return MediaCellViewModel(photo: model)
            })
            self.cellVMs += newCellVMs
            pageUp()
        }
    }
    
}
