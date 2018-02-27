//
//  VideoTableViewController.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class VideoTableViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = VideosViewModel()
    weak var delegate: MainPageScrollViewDelegate?
    var refreshControl = UIRefreshControl()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
    }

    // MARK: - Build
    func buildTableView() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.build()
        tableView.register(cellType: .video)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        loadData()
        
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 120.0))
        headerView.backgroundColor = .white
        tableView.tableHeaderView = headerView
    }
    
    override func didDismissMediaDetailPageViewController(_ vc: MediaDetailPageViewController, indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        }
        
    }
}

// MARK: - UITableViewDataSource
extension VideoTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = viewModel.cellVMs[indexPath.row]
        let cell = tableView.dequeue(cellType: .video, indexPath: indexPath)
        cell.build(viewModel: vm)
        return cell
    }
}


// MARK: - UITableViewDelegate
extension VideoTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        presentDetailContentVC(cellVMs: viewModel.cellVMs, indexPath: indexPath)
    }
}

// MARK: - UIScrollViewDelegate
extension VideoTableViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let delegate = delegate {
            delegate.mainPageScrollViewDidScroll(scrollView)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
}


// MARK: - Network
extension VideoTableViewController {
    func loadData(_ isPageUp: Bool = false) {
        var loadingParentView: UIView? = nil
        
        if isPageUp {
            if !viewModel.canPageUp {
                return
            }
        } else {
            loadingParentView = self.tableView
        }
        
        request(target: viewModel.paginationManager!.requestTarget, loadingView: loadingParentView, bakerViewType: .bottom, success: { (model) in
            self.loadedData(model: model)
        }, failure: nil)
    }
    
    func loadedData(model: ResponseModel) {
        self.viewModel.loadedData(responseModel: model)
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    @objc func refreshData() {
        self.viewModel.refreshData()
        self.tableView.reloadData()
        self.loadData()
    }
    
    func pageUpIfNeeded() {
        if !viewModel.canPageUp {
            return
        }
        self.loadData(true)
    }
}


