//
//  LoadingView.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    static func show(title: String? = nil, parentView: UIView) -> LoadingView {
        let view = Bundle.main.loadNibNamed(String(describing: LoadingView.self), owner: nil, options: nil)?.first as! LoadingView
        view.activityIndicatorView.startAnimating()
        view.titleLabel.text = title ?? "LOADING..."
        parentView.addSubview(view)
        view.center = parentView.center
        return view
    }
    
    
    func hide() {
        self.removeFromSuperview()
    }
}
