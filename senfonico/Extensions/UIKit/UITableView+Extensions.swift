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
    
    func build() {
        self.tableFooterView = UIView(frame: .zero)
        self.tableHeaderView = UIView(frame: .zero)
    }
    
    func register(cellType: UITableView.CellType) -> Void {
        self.register(UINib(nibName: cellType.nibName, bundle: nil), forCellReuseIdentifier: cellType.identifier)
    }
    
    
    func dequeue(cellType: UITableView.CellType, indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        return cell
    }
    
    
}

// MARK: - Cell Type
extension UITableView {
    enum CellType: CellTypeProtocol {
        case coffee // ☕️
        case video
    
        var identifier: String {
            switch self {
            case .video:
                return String(describing: VideoTableViewCell.self)
            default:
                break
            }
            return "CellIdentifier"
        }
        
        var nibName: String {
            return identifier
        }
    }
}
