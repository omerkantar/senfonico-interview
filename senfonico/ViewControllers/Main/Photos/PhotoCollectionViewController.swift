//
//  PhotoCollectionViewController.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellSize: CGSize = .zero
    
    weak var delegate: MainPageScrollViewDelegate?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

    // MARK: - Build
    func build() {
        collectionView.contentInset = UIEdgeInsetsMake(0.0, 5.0, 5.0, 5.0)
        collectionView.register(cellType: .photo)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}



// MARK: - UICollectionViewDataSource
extension PhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cellType: .photo, indexPath: indexPath, viewModel: BaseCellViewModel())
        return cell
    }
}


extension PhotoCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard cellSize == .zero else {
            return cellSize
        }
        
        let width: CGFloat = (collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right) / 3.0
        cellSize = CGSize(width: width, height: width)
        return cellSize
    }
}

// MARK: - UIScrollViewDelegate
extension PhotoCollectionViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let delegate = delegate {
            delegate.mainPageScrollViewDidScroll(scrollView)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
}
