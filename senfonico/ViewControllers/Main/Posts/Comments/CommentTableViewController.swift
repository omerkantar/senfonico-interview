//
//  CommentTableViewController.swift
//  senfonico
//
//  Created by omer kantar on 28.02.2018.
//  Copyright © 2018 senfonico-interview. All rights reserved.
//

import UIKit

class CommentTableViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
    var postModel: PostModel?
    var viewModel = CommentsViewModel()
    let manager = CommentsManager.sharedInstance
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        designing()
        buildTableView()
        addKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let headerView = tableView.tableHeaderView {
            headerView.frame.size.height = 0.0
            headerView.backgroundColor = .clear
            tableView.tableHeaderView = headerView
        }
    }

    // MARK: - Build
    func designing() {
        textView.contentInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
        textView.layer.cornerRadius = textView.bounds.height / 2.0
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.backgroundColor = UIColor.dirtyWhite
    }
    
    func buildTableView() {
        tableView.build()
        tableView.register(cellTypes: [.post, .comment])
        tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 51.0, 0.0)
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        
    }
    
    // MARK: - Keyboard
    override func keyboardWillShow(_ notification: Notification) {
        scrollBottomCell()
        super.keyboardWillShow(notification)
    }
    override func keyboardFoundFrame(frame: CGRect) {
        self.updateBottomViewBottomConstraint(-frame.size.height)
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        self.updateBottomViewBottomConstraint(0)
    }
    
    func updateBottomViewBottomConstraint(_ constant: CGFloat) {
        self.bottomViewBottomConstraint.constant = constant
        self.tableViewBottomConstraint.constant = constant
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func scrollBottomCell() {
        guard let count = viewModel.cellVMs?.count else {
            return
        }
        if count <= 1 {
            return
        }
        let indexPath = IndexPath(row: count-1, section: 0)
        DispatchQueue.main.async {
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    // MARK: - Navigation Bar
    override func navigationBarBackgroundColor() -> UIColor? {
        return .white
    }
    
    override func isShowingNavigationBar() -> Bool {
        return true
    }
    
    // MARK: - Actions
    @IBAction func sendButtonTapped() {
        textView.resignFirstResponder()
        guard let text = textView.text, let model = postModel else {
            return
        }
        
        let empty = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if empty.count < 1 {
            return
        }
        
        let comment = CommentModel.me(body: text, postId: model.postId)
        let vm = CommentCellViewModel(model: comment)
        self.viewModel.cellVMs?.append(vm)
        let indexPath = IndexPath(row: self.viewModel.cellVMs!.count-1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.bottom)
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        model.comments.append(comment)
        manager.save(model: model)
        textView.text = nil
        
    }
   
}

// MARK: - UITableViewDataSource
extension CommentTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellVMs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel.cellVMs?[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeue(cellType: .comment, indexPath: indexPath, viewModel: vm)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CommentTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let model = postModel else {
            return nil
        }
        let vm = PostCellViewModel(model: model)
        let headerView = tableView.dequeue(cellType: .post, viewModel: vm)
        return headerView
    }
    
}


// MARK: - Network
extension CommentTableViewController {
    func loadData() {
        guard let post = postModel else {
            return
        }
        
        if let model = manager.postModel(postId: post.postId) {
            viewModel.build(postModel: model)
            self.tableView.reloadData()
            self.scrollBottomCell()
        } else {
            request(target: .comments(postId: post.postId), loadingView: self.tableView, bakerViewType: .bottom, success: { (model) in
                self.loadedData(model: model)
            }, failure: nil)
        }
    }
    
    func loadedData(model: ResponseModel) {
        self.viewModel.build(responseModel: model, postModel: postModel!)
        self.tableView.reloadData()
    }
}
