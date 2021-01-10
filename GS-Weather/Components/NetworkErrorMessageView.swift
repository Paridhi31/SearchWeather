//
//  NetworkErrorMessageView.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 10/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

typealias RetryButtonAction = () -> ()

class NetworkErrorMessageView: UIView {

    let title: UILabel = {
        let label = UILabel()
        label.text = "Network error"
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.text = "You don't seem to be connected with internet, Please check your internet connection"
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        addSubview(title)
        addSubview(subtitle)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0),
            title.heightAnchor.constraint(equalToConstant: 44.0)
        ])
        
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            subtitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15.0),
            subtitle.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
