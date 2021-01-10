//
//  WeatherDetailsView.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 03/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

class WeatherDetailsListView: UIView {
    
    var weatherInfoListView: [RowView] = [RowView]()
    
    init(viewModel: WeatherDetailsListViewModel?) {
        super.init(frame: .zero)
        if let viewModel = viewModel {
            bind(viewModel: viewModel)
            setupConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(viewModel: WeatherDetailsListViewModel) {
        for rowVM in viewModel.weatherInfolistVM {
            let rowView = RowView.init(rowViewModel: RowViewModel(model: RowModel(key: rowVM.key!, value: rowVM.value!)))
            weatherInfoListView.append(rowView)
        }
    }
    
    private func setupConstraints() {
        let count = weatherInfoListView.count
        for index in 0..<count {
            let row: RowView = weatherInfoListView[index]
            self.addSubview(row)
            row.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                row.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
                row.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            ])
            if index == 0 {
                row.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.0).isActive = true
            } else {
                let previousView = weatherInfoListView[index - 1]
                row.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 44.0).isActive = true
            }
            
            if index == count - 1 {
                row.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            }
        }
    }
}
