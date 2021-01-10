//
//  RowView.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 05/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

class RowView: UIView {

    let baseContainer: UIView = UIView()
    
    let leftLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        return label
    }()

    init(rowViewModel: RowViewModel) {
        super.init(frame: .zero)
        leftLabel.text = rowViewModel.key
        rightLabel.text = rowViewModel.value
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(baseContainer)
        
        baseContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0),
            baseContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0),
            baseContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0),
            baseContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0)
        ])

        baseContainer.addSubview(leftLabel)
        baseContainer.addSubview(rightLabel)
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: baseContainer.leadingAnchor, constant: 0.0),
            leftLabel.topAnchor.constraint(equalTo: baseContainer.topAnchor, constant: 0.0),
            leftLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2)
        ])

        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor, constant: 0.0),
            rightLabel.trailingAnchor.constraint(equalTo: baseContainer.trailingAnchor, constant: 0.0),
            rightLabel.topAnchor.constraint(equalTo: baseContainer.topAnchor, constant: 0.0)
        ])
    }
}
