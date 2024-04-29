//
//  ReposViewController.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 29.4.24..
//

import UIKit
import SwiftUI

final class RepoListViewController: UIViewController {
    
    private let reposTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ReposTableViewCell.self,
                           forCellReuseIdentifier: ReposTableViewCell.cellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 8
        tableView.clipsToBounds = true
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reposTableView.dequeueReusableCell(withIdentifier: ReposTableViewCell.cellIdentifier, for: indexPath) as! ReposTableViewCell
        return cell
    }
}

struct RepoListView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RepoListViewController {
        return RepoListViewController()
    }
    
    func updateUIViewController(_ uiViewController: RepoListViewController, context: Context) {}
}
