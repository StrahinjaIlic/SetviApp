//
//  ReposTableViewCell.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 29.4.24..
//

import UIKit

final class ReposTableViewCell: UITableViewCell {
    
    private let repoTitle: UILabel = {
        let label = UILabel()
        label.text = "Test 1"
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReposTableViewCell {
    
    private func setupViews() {
        contentView.backgroundColor = .secondarySystemBackground
        
        let padding: CGFloat = 16
        
        contentView.addSubview(repoTitle)
        NSLayoutConstraint.activate([
            repoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            repoTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            repoTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            repoTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
        ])
    }
}
