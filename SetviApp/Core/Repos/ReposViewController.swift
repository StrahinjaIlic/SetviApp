//
//  ReposViewController.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 29.4.24..
//

import UIKit
import SwiftUI

// Because i have lack of time to do list of commits (it would be anyway same logic) I decide to do repos in UIKit

final class RepoListViewController: UIViewController {
    
    private var viewModel: ReposViewModel
    
    private let reposTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ReposTableViewCell.self,
                           forCellReuseIdentifier: ReposTableViewCell.cellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.clipsToBounds = true
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        viewModel.fetchRepos()
        
        viewModel.isLoading.onUpdate = { [weak self] isLoading in
            if !isLoading {
                self?.reposTableView.reloadData()
            }
        }
    }
    
    init(viewModel: ReposViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RepoListViewController {
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(reposTableView)
        
        NSLayoutConstraint.activate([
            reposTableView.topAnchor.constraint(equalTo: view.topAnchor),
            reposTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            reposTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            reposTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        reposTableView.delegate = self
        reposTableView.dataSource = self
    }
}

extension RepoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRepoCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reposTableView.dequeueReusableCell(
            withIdentifier: ReposTableViewCell.cellIdentifier, for: indexPath) as! ReposTableViewCell
        let model = viewModel.getRepo(for: indexPath)
        cell.configure(name: model.name)
        return cell
    }
}

struct RepoListView: UIViewControllerRepresentable {
    @ObservedObject var viewModel: ReposViewModel
    
    init(viewModel: ReposViewModel) {
        self.viewModel = viewModel
    }
    
    func makeUIViewController(context: Context) -> RepoListViewController {
        return RepoListViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: RepoListViewController, context: Context) {}
}
