//
//  PhotosViewModel.swift
//  senfonico
//
//  Created by omer kantar on 26.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PhotosViewModel: MediasViewModel {

    override init() {
        super.init()
        self.paginationManager = PhotosPaginationManager()
    }
    
    override func mediaType() -> MediaPageModel.MediaType? {
        return .image
    }
    
}
