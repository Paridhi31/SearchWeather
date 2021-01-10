//
//  FavoriteDestinationCell.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 03/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

class FavoriteDestinationCell: UITableViewCell {
    
    lazy var destinationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "San Francisco", size: 14.0)
        return label
    }()
        
    //MARK: Initilization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI Setup
    private func addSubviews() {
        addSubview(destinationLabel)
        addDestinationLabelConstraints()
    }
    
    private func addDestinationLabelConstraints() {
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            destinationLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.0),
            destinationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15.0),
            destinationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func bind(viewModel: FavoriteDestinationCellVM) {
        destinationLabel.text = viewModel.destination
    }
}

