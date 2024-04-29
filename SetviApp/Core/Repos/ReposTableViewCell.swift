//
//  ReposTableViewCell.swift
//  SetviApp
//
//  Created by Strahinja Ilic on 29.4.24..
//

import UIKit

final class ReposTableViewCell: UITableViewCell {
    
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
        contentView.backgroundColor = .blue
    }
}
