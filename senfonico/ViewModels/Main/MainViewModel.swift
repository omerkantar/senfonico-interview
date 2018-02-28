//
//  MainViewModel.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit


class MainViewModel {

    var pageController: PageViewController?
    var photoCollectionVC: PhotoCollectionViewController?
    var videoTableVC: VideoTableViewController?
    var postTableVC: PostTableViewController?
    
    init() {
        self.setup()
    }
    
    fileprivate func setup() {
        pageController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        photoCollectionVC = PhotoCollectionViewController()
        videoTableVC = VideoTableViewController()
        postTableVC = PostTableViewController()
        pageController?.tabViewControllers = [photoCollectionVC!, postTableVC!]
    }
}
