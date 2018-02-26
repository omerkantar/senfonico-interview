//
//  PhotoCollectionViewController.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellSize: CGSize = .zero
    
    weak var delegate: MainPageScrollViewDelegate?
    
    var refreshControl = UIRefreshControl()
    
    var viewModel = PhotosViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

    // MARK: - Build
    func build() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.contentInset = UIEdgeInsetsMake(0.0, 5.0, 5.0, 5.0)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerIdentifier")
        collectionView.register(cellType: .photo)
        collectionView.delegate = self
        collectionView.dataSource = self
        loadData()
    }
    
}



// MARK: - UICollectionViewDataSource
extension PhotoCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.cellVMs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vm = self.viewModel.cellVMs[indexPath.row]
        let cell = collectionView.dequeue(cellType: .photo, indexPath: indexPath, viewModel: vm)
        return cell
    }
}


extension PhotoCollectionViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerIdentifier", for: indexPath)
            
            reusableView.backgroundColor = .clear
            return reusableView
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0.0, height: 120.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard cellSize == .zero else {
            return cellSize
        }
        
        let width: CGFloat = (collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right - (2.0 * 2.0)) / 3.0
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
        
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.height - 20.0) {
         self.pageUpIfNeeded()
        }
    }
    
}

// MARK: - Network
extension PhotoCollectionViewController {
    func loadData(_ isPageUp: Bool = false) {
        var loadingParentView: UIView? = nil
        
        if isPageUp {
            if !viewModel.canPageUp {
                return
            }
        } else {
            loadingParentView = self.collectionView
        }
        
        request(target: viewModel.paginationManager.requestTarget, loadingView: loadingParentView, bakerViewType: .bottom, success: { (model) in
            self.loadedData(model: model)
        }, failure: nil)
    }
    
    func loadedData(model: ResponseModel) {
        self.viewModel.loadedData(responseModel: model)
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    @objc func refreshData() {
        self.viewModel.refreshData()
        self.collectionView.reloadData()
        self.loadData()
    }
    
    func pageUpIfNeeded() {
        if !viewModel.canPageUp {
            return
        }
        self.loadData(true)
    }
}
