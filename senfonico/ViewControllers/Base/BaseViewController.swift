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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        designingNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        designingNavigationBar()
    }
    
    // MARK: - NavigationBar design
    func updateNavigationBarDesign() {
        designingNavigationBar()
    }
    
    func isShowingNavigationBar() -> Bool {
        return false
    }
    
    func navigationBarBackgroundColor() -> UIColor? {
        return nil
    }
    
    // MARK: - Keyboard Notifications
    func addKeyboardNotifications() {
        // MARK: - Dealocta remove edilmektedir

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)

    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let frame = getKeyboardFrame(notification: notification) else {
            return
        }
        keyboardFoundFrame(frame: frame)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        guard let frame = getKeyboardFrame(notification: notification) else {
            return
        }
        keyboardFoundFrame(frame: frame)

    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
    }
    
    func keyboardFoundFrame(frame: CGRect) {
        
    }
    
    func getKeyboardFrame(notification: Notification) -> CGRect? {
        guard let userInfo = notification.userInfo, let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return nil
        }
        return self.view.convert(keyboardFrame, from: nil)
    }
    
}

// MARK: - NavigationBarDesign
fileprivate extension BaseViewController {
    func designingNavigationBar() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: #selector(popVC))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let showingNavigationBar = isShowingNavigationBar()
        var backgroundColor = showingNavigationBar ? UIColor.white : UIColor.clear
        if let color = navigationBarBackgroundColor() {
            backgroundColor = color
        }
        self.navigationController?.navigationBar.backgroundColor = backgroundColor
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
       

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
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentVC(_ vc: UIViewController, animated: Bool = true) {
        self.present(vc, animated: true, completion: nil)
    }
    
    func pushVC(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentDetailContentVC(cellVMs: [MediaCellViewModel], indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "mediaDetailPageVC") as! MediaDetailPageViewController
        
        vc.delegate = self
        vc.currentIndexPath = indexPath
        vc.cellVMs = cellVMs
        self.presentVC(vc)
    }
}

// MARK: - MediaDetailPageDelegate
extension BaseViewController: MediaDetailPageDelegate {
    @objc func didDismissMediaDetailPageViewController(_ vc: MediaDetailPageViewController, indexPath: IndexPath) {
        
    }
}

