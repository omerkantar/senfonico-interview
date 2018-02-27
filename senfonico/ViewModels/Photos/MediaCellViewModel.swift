//
//  PhotoCellViewModel.swift
//  senfonico
//
//  Created by omer kantar on 26.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class MediaCellViewModel: BaseCellViewModel {

    var imageURL: URL?
    var model: PhotoModel
    var videoURL: URL?
    var text: String?
    
    init(photo: PhotoModel) {
        // Burada image logic calismasi daha iyi cell load ederken olabildigince az logic calismali 🦄
        self.model = photo
        self.imageURL = photo.imageURL
        
        var txt = ""
        if let title = photo.title {
            txt += title + "\n"
        }
        if let dimentionText = photo.maxDimensionsModel?.text {
            txt += dimentionText
        }
        self.text = txt
        if photo is VideoModel {
            self.videoURL = (photo as? VideoModel)?.videoURL
        }
    }
}
