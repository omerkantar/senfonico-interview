//
//  UIImageView.swift
//  senfonico
//
//  Created by omer kantar on 25.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

extension UIImageView {
    func image(url: URL?, placeholder: UIImage? = nil) {
        guard let url = url else {
            self.image = placeholder
            return
        }
        
        URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
        
        
    }
}
