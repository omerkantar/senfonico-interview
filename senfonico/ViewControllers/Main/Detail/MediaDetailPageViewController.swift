//
//  DetailContentViewController.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

protocol MediaDetailPageDelegate: NSObjectProtocol {
    func didDismissMediaDetailPageViewController(_ vc: MediaDetailPageViewController, indexPath: IndexPath) -> Void
}

class MediaDetailPageViewController: UIViewController {

    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var cellVMs: [MediaCellViewModel]?
    var currentIndexPath = IndexPath(row: 0, section: 0)
    var pageViewController: UIPageViewController?
    weak var delegate: MediaDetailPageDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK: - Build
    func build() {
        self.view.isUserInteractionEnabled = true
        self.containerView.isUserInteractionEnabled = true
        
        self.containerView.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(containerViewTapped))
        self.containerView.addGestureRecognizer(tapGR)
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController?.dataSource = self
        pageViewController?.delegate = self
        pageViewController?.automaticallyAdjustsScrollViewInsets = false
        
        guard let pageViewController = pageViewController else {
            return
        }
        
        self.containerView.addSubview(pageViewController.view)
        pageViewController.willMove(toParentViewController: self)
        self.addChildViewController(pageViewController)
        pageViewController.didMove(toParentViewController: self)
        
        if let vc = self.contentVC(index: self.currentIndexPath.row) {
            pageViewController.setViewControllers([vc],
                                                  direction: .forward,
                                                  animated: false,
                                                  completion: nil)
        }
        
        
        DispatchQueue.main.async {
            pageViewController.view.frame = CGRect(origin: CGPoint.zero, size: self.containerView.frame.size)
            
           
        }
    }
    
    // MARK: - Show hide content
    
    func isShowingContent() -> Bool {
        return !self.closeButton.isHidden
    }
    
    func hideContent() {
        let vc = self.pageViewController?.viewControllers?.first as? MediaDetailContentViewController
        UIView.animate(withDuration: 0.2, animations: {
            self.closeButton.alpha = 0.0
            vc?.titleLabel.alpha = 0.0
            vc?.shareButton.alpha = 0.0
        }) { (fns) in
            self.closeButton.isHidden = true
            vc?.shareButton.isHidden = true
        }
    }
    
    func showContent() {
        let vc = self.pageViewController?.viewControllers?.first as? MediaDetailContentViewController
        let alpha: CGFloat = 1.0
        UIView.animate(withDuration: 0.2, animations: {
            self.closeButton.alpha = alpha
            vc?.titleLabel.alpha = alpha
            vc?.shareButton.alpha = alpha
        }) { (fns) in
            self.closeButton.isHidden = false
            vc?.shareButton.isHidden = false
        }
    }
    
    @objc func containerViewTapped() {
        if isShowingContent() {
            hideContent()
        } else {
            showContent()
        }
    }
 
    
    
    // MARK: -
    func contentVC(index: Int) -> MediaDetailContentViewController? {
        guard let cellVMs = cellVMs else {
            return nil
        }
        if cellVMs.count - 1 < index || index < 0 {
            return nil
        }
        let vm = cellVMs[index]
        let vc = MediaDetailContentViewController()
        vc.viewModel = vm
        vc.index = index
        vc.totalCount = cellVMs.count
        return vc
    }

    // MARK: - Action
    @IBAction func dismissButtonTapped() {
        self.dismiss(animated: true) {
            if let delegate = self.delegate {
                delegate.didDismissMediaDetailPageViewController(self, indexPath: self.currentIndexPath)
            }
        }
    }
}


// MARK: - UIPageControllerDataSource
extension MediaDetailPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func nextViewController(_ viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        
        guard let vc = viewController as? MediaDetailContentViewController, let vm = vc.viewModel else {
            return nil
        }
        
        guard var index = cellVMs?.index(where: { $0.model.id == vm.model.id })  else {
            return nil
        }
        
        if isAfter {
            index += 1
        } else {
            index -= 1
        }
        
        if let vc = contentVC(index: index) {
            currentIndexPath.row = index
            return vc
        }
        return nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: false)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: true)
    }
}

// MARK: - UIPanGestureRecognizer
extension MediaDetailPageViewController {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        showContent()
    }
    
}
