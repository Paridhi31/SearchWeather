//
//  NoFavoritesAvailableCell.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 10/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

class NoFavoritesAvailableCell: UITableViewCell {

    lazy var noFavAvailablelabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "San Francisco", size: 14.0)
        label.text = "No Favorites Available"
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
        addSubview(noFavAvailablelabel)
        noFavAvailablelabelConstraints()
    }
    
    private func noFavAvailablelabelConstraints() {
        noFavAvailablelabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noFavAvailablelabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15.0),
            noFavAvailablelabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15.0),
            noFavAvailablelabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noFavAvailablelabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)

        ])
    }
}
