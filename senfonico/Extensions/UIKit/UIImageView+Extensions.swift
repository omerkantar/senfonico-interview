//
//  UIImageView.swift
//  senfonico
//
//  Created by omer kantar on 25.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func image(url: URL?, placeholder: UIImage? = nil, mode: UIViewContentMode? = nil, completion: ((_ data: Data) -> Void)? = nil) {
        guard let url = url else {
            self.image = placeholder
            self.contentMode = .center
            return
        }
        
        self.image = placeholder
        self.contentMode = .center
        
        
        URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            
            if let completion = completion,
                let data = data {
                completion(data)
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.contentMode = mode ?? UIViewContentMode.scaleAspectFill
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
        
        
    }
}
