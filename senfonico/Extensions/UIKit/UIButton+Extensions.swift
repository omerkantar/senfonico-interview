//
//  UIButton+Extensions.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

extension UIButton {
    func selectedDesign() {
        self.setTitleColor(UIColor.black, for: .normal)
    }
    
    func noneSelectedDesign() {
        self.setTitleColor(UIColor.gray, for: .normal)
    }
}
