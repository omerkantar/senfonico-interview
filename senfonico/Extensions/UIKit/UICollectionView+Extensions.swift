//
//  UICollectionView+Extensions.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register(cellType: UICollectionView.CellType) {
        self.register(UINib(nibName: cellType.nibName, bundle: nil), forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeue(cellType: UICollectionView.CellType, indexPath: IndexPath, viewModel: BaseCellViewModel? = nil) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath)
        if let vm = viewModel {
            cell.build(viewModel: vm)
        }
        return cell
    }
    
}


// MARK: - Enum
extension UICollectionView {
    enum CellType: CellTypeProtocol {
        case tea
        case photo

        var identifier: String {
            switch self {
            case .photo:
                return String(describing: PhotoCollectionViewCell.self)
            default:
                break
            }
            return "cellIdentifier"
        }
        
        var nibName: String {
            return identifier
        }
    }
}
