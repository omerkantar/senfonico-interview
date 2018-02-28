//
//  UITableView+Extensions.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

// MARK: - Register & Dequeue

extension UITableView {
    
    func build() {
        self.tableFooterView = UIView(frame: .zero)
        self.tableHeaderView = UIView(frame: .zero)
    }

    func register(cellType: UITableView.CellType) -> Void {
        self.register(UINib(nibName: cellType.nibName, bundle: nil), forCellReuseIdentifier: cellType.identifier)
    }
    
    func register(cellTypes: [UITableView.CellType]) -> Void {
        for type in cellTypes {
            self.register(cellType: type)
        }
    }
    
    
    func dequeue(cellType: UITableView.CellType, indexPath: IndexPath? = nil, viewModel: BaseCellViewModel? = nil) -> UITableViewCell {
        
        var cell: UITableViewCell?
        if let indexPath = indexPath {
            cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        }
        cell = self.dequeueReusableCell(withIdentifier: cellType.identifier)
        guard let view = cell else {
            return UITableViewCell()
        }
        if let vm = viewModel {
            view.build(viewModel: vm)
        }
        return view
    }
    
    
}

// MARK: - Cell Type
extension UITableView {
    enum CellType: CellTypeProtocol {
        case coffee // ☕️
        case video
        case post
        case comment
        
        var identifier: String {
            switch self {
            case .video:
                return String(describing: VideoTableViewCell.self)
            case .post:
                return String(describing: PostTableViewCell.self)
            case .comment:
                return String(describing: CommentTableViewCell.self)
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
