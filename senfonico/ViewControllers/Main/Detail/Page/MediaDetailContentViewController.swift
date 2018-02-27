//
//  MediaDetailContentViewController.swift
//  senfonico
//
//  Created by omer kantar on 27.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class MediaDetailContentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    var viewModel: MediaCellViewModel?
    var imageData: Data?
    var index: Int = 0
    var totalCount: Int = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.build()
        }
            
    }

    // MARK: -
    func build() {
        guard let vm = viewModel else {
            return
        }
        
        self.titleLabel.text = vm.text
        if let videoURL = vm.videoURL {
            self.buildWebView(url: videoURL)
        } else {
            self.buildImageView(url: vm.imageURL)
        }
    }
    
    
    func buildWebView(url: URL) {
        self.imageView.isHidden = true
        self.webView.isHidden = false
        self.webView.delegate = self
        self.webView.loadRequest(URLRequest(url: url))
        self.webView.scrollView.showsVerticalScrollIndicator = false
        self.webView.scrollView.showsHorizontalScrollIndicator = false
    }
    
    func buildImageView(url: URL?) {
        self.webView.isHidden = true
        self.imageView.isHidden = false
        self.imageView.image(url: url, placeholder: #imageLiteral(resourceName: "placeholder_mountain"), mode: UIViewContentMode.scaleAspectFit) { (data) in
            self.imageData = data
        }
        
    }
    
    // MARK: - Actions
    @IBAction func shareButtonTapped() {
        if let data = imageData {
            showShareVC(items: [data])
        } else  if let videoURL = viewModel?.videoURL {
            showShareVC(items: [videoURL.absoluteString])

        } else if let imageURL = viewModel?.imageURL {
            showShareVC(items: [imageURL.absoluteString])
        }
    }
    
    func showShareVC(items: [Any]) {
        
    }

}
// MARK: - WebViewDelegate
extension MediaDetailContentViewController: UIWebViewDelegate {
    
}
