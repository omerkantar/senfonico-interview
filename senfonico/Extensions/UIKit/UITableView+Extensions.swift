//
//  UITableView+Extensions.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

// MARK: - Register & Deque
extension UITableView {
    
    func build(rowHeight: CGFloat? = nil) {
        
    }
    
    func register(cellType: UITableView.CellType) -> Void {
        self.register(UINib(nibName: cellType.nibName, bundle: nil), forCellReuseIdentifier: cellType.cellIdentifier)
    }
    
    
    func dequeue(cellType: UITableView.CellType, indexPath: NSIndexPath) -> CellViewDataSource {
        
    }
    
    
}

// MARK: - Cell Type
extension UITableView {
    enum CellType {
        case coffee // ☕️
        case photo
        case video
    
        var cellIdentifier: String {
            switch self {
            case .photo:
                return String(describing: PhotoCollectionViewCell.self)
            case .video:
                return String(describing: VideoTableViewCell.self)
            default:
                break
            }
            return "CellIdentifier"
        }
        
        var nibName: String {
            return cellIdentifier
        }
    }
}
