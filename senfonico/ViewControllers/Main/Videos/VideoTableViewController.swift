//
//  VideoTableViewController.swift
//  senfonico
//
//  Created by omer kantar on 23.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class VideoTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    weak var delegate: MainPageScrollViewDelegate?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
    }

    // MARK: - Build
    func buildTableView() {
        tableView.build()
        tableView.register(cellType: .video)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension VideoTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: .video, indexPath: indexPath)
        cell.build(viewModel: BaseCellViewModel())
        return cell
    }
}


// MARK: - UITableViewDelegate
extension VideoTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
