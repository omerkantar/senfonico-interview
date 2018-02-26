//
//  String+Extensions.swift
//  senfonico
//
//  Created by omer kantar on 26.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import Foundation


extension String {
    var url: URL? {
        return URL(string: self)
    }
}
