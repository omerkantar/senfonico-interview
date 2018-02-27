//
//  MainViewController.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet weak var videosButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!
    
    var activeButton: UIButton?
    var viewModel: MainViewModel?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

    // MARK: - Build
    func build() {
        photosButton.selectedDesign()
        videosButton.noneSelectedDesign()
        activeButton = photosButton
        
        viewModel = MainViewModel()
        viewModel?.photoCollectionVC?.delegate = self
        viewModel?.videoTableVC?.delegate = self
        viewModel?.pageController?.pageDelegate = self
        
        guard let pageController = viewModel?.pageController else {
            return
        }
        pageController.view.clipsToBounds = false
        self.containerView.addSubview(pageController.view)
        self.addChildViewController(pageController)
        DispatchQueue.main.async {
            pageController.view.frame = CGRect(origin: CGPoint.zero, size: self.containerView.bounds.size)
        }
    }
    
    @IBAction func photosButtonTapped() {
        guard let button = activeButton else {
            return
        }
        if button == photosButton {
            return
        }
        activeButton?.noneSelectedDesign()
        photosButton.selectedDesign()
        activeButton = photosButton
        viewModel?.pageController?.displayControllerWithIndex(0, animated: true)
    }
    
    @IBAction func videosButtonTapped() {
        guard let button = activeButton else {
            return
        }
        if button == videosButton {
            return
        }
        activeButton?.noneSelectedDesign()
        videosButton.selectedDesign()
        activeButton = videosButton
        viewModel?.pageController?.displayControllerWithIndex(1, animated: true)
    }

}

// MARK: - PageViewControllerDelegate
extension MainViewController: PageViewControllerDelegate {
    func pageViewController(pageVC: PageViewController, didChanged currentPage: Int) {
        
        guard let button = activeButton else {
            return
        }
       
        switch button {
        case photosButton:
            if currentPage == 0 {
                return
            }
            activeButton?.noneSelectedDesign()
            videosButton.selectedDesign()
            self.activeButton = videosButton
            break
        case videosButton:
            if currentPage == 1 {
                return
            }
            activeButton?.noneSelectedDesign()
            photosButton.selectedDesign()
            self.activeButton = photosButton
            break
        default:
            break
        }
        
    }
}

// MARK: - ScrollViewDelegate
extension MainViewController: MainPageScrollViewDelegate {
    func mainPageScrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY: CGFloat = scrollView.contentOffset.y
        let constraint: CGFloat = CGFloat(max(90.0, 140.0-offsetY))
        if self.headerHeightConstraint.constant != constraint {
            self.headerHeightConstraint.constant = constraint
        }
//        let topConstant: CGFloat = offsetY <= 0 ? 120.0 : 70.0
//        if self.containerTopConstraint.constant != topConstant {
//            self.containerTopConstraint.constant = topConstant
//        }
    }
}
