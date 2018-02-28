//
//  PostsTableViewController.swift
//  senfonico
//
//  Created by omer kantar on 28.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class PostTableViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = PostsViewModel()
    weak var delegate: MainPageScrollViewDelegate?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buildTableView()
    }
    
    // MARK: - Build
    func buildTableView() {
        
        tableView.build()
        tableView.register(cellType: .post)
        tableView.delegate = self
        tableView.dataSource = self
        
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 120.0))
        headerView.backgroundColor = .white
        tableView.tableHeaderView = headerView
        loadData()
    }
}

// MARK: - UITableViewDataSource
extension PostTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postCellVMs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel.postCellVMs?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeue(cellType: .post, indexPath: indexPath, viewModel: vm)
        return cell
    }
}


// MARK: - UITableViewDelegate
extension PostTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let model = viewModel.postCellVMs?[indexPath.row].model else {
            return
        }
        
        let vc = CommentTableViewController()
        vc.postModel = model
        pushVC(vc)
    }
}

// MARK: - UIScrollViewDelegate
extension PostTableViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let delegate = delegate {
            delegate.mainPageScrollViewDidScroll(scrollView)
        }
    }
}


// MARK: - Network
extension PostTableViewController {
    func loadData() {
        request(target: .posts, loadingView: self.tableView, bakerViewType: .bottom, success: { (model) in
            self.loadedData(model: model)
        }, failure: nil)

    }
    
    func loadedData(model: ResponseModel) {
        self.viewModel.build(response: model)
        self.tableView.reloadData()
    }
}
