//
//  UITableViewCell+Extensions.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

// MARK: - NSObjectProtocol yaparak o func ovverride edebiliriz 💃
protocol CellViewDataSource: NSObjectProtocol {
    func build(viewModel: BaseCellViewModel) -> Void
}

extension UITableViewCell: CellViewDataSource {
    func build(viewModel: BaseCellViewModel) { }
}

extension UICollectionViewCell: CellViewDataSource {
    func build(viewModel: BaseCellViewModel) { }
}
