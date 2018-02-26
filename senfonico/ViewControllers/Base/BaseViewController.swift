//
//  BaseViewController.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    
    var isLoading: Bool = false
    
    var bakerView: BakerView?
    var loadingView: LoadingView?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        designingNavigationBar()
    }
    
    // MARK: - Build
    func updateNavigationBarDesign() {
        designingNavigationBar()
    }
    
}

// MARK: - NavigationBarDesign
fileprivate extension BaseViewController {
    func designingNavigationBar() {
        
    }
    
    
}

// MARK: - Request
extension BaseViewController {
    func request(target: RequestTarget,
                 loadingMessage: String? = nil,
                 loadingView: UIView? = nil,
                 isShowingErrorMessage: Bool = false,
                 bakerViewType: BakerView.FrameType? = nil,
                 bakerViewParentView: UIView? = nil,
                 success: NetworkSuccessBlock?,
                 failure: NetworkFailureBlock?) -> Void {
        
        if isLoading {
            return
        }
        isLoading = true
        if let parentView = loadingView {
            self.loadingView = LoadingView.show(title: loadingMessage, parentView: parentView)
        }
        
        if let type = bakerViewType {
            self.bakerView = BakerView.show(type: type, parentView: bakerViewParentView)
        }
        
        ServiceManager.request(target: target, success: { (model) in
            
            DispatchQueue.main.async {
                self.stopViews()
                if let success = success {
                    success(model)
                }
                self.isLoading = false
            }

        }) { (error, model) in
            DispatchQueue.main.async {
                self.stopViews()
                if let failure = failure {
                    failure(error, model)
                }
                self.isLoading = false
            }
        }
    }
    
    func stopViews() {
        self.loadingView?.hide()
        self.bakerView?.stopAnimation()
        self.bakerView = nil
        self.loadingView = nil
    }
}


// MARK: - Pop push present
extension BaseViewController {
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentVC(_ vc: UIViewController, animated: Bool = true) {
        self.present(vc, animated: true, completion: nil)
    }
    
    func pushVC(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentDetailContentVC() {
        
    }
}

