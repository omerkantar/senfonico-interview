//
//  BaseViewController.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    
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
    func request(target: APITarget,
                 loadingMessage: String?,
                 loadingView: UIView?,
                 success: NetworkSuccessBlock?,
                 failure: NetworkFailureBlock?) -> Void {
        
        
        ServiceManager.request(target: target, success: { (model) in
        
            if let success = success {
                success(model)
            }
        }) { (error, model) in
            
            
            if let failure = failure {
                failure(error, model)
            }
        }
    }
}
