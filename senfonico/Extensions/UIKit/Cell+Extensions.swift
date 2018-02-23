//
//  UITableViewCell+Extensions.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

protocol CellViewDataSource {
    func build(viewModel: BaseCellViewModel) -> Void
}

// MARK: - @objc func yaparak o func override edebiliriz 💃
extension UITableViewCell: CellViewDataSource {
    @objc func build(viewModel: BaseCellViewModel) { }
}

extension UICollectionViewCell: CellViewDataSource {
    @objc func build(viewModel: BaseCellViewModel) { }
}
