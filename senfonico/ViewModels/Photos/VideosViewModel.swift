//
//  VideosViewModel.swift
//  senfonico
//
//  Created by omer kantar on 26.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class VideosViewModel: MediasViewModel {

    
    override init() {
        super.init()
        self.paginationManager = VideosPaginationManager()
    }
    
    
    override func mediaType() -> MediaPageModel.MediaType? {
        return .video
    }
    
}
