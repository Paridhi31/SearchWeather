//
//  WeatherDetailsViewModel.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 03/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

class WeatherDetailsListViewModel {
    
    var name: String?
    
    var weatherInfolistVM: [RowViewModel] = [RowViewModel]()
    
    init(model: WeatherInfoModel?) {
        for (key, value) in model?.weatherDetailsDict ?? [:] {
            let rowVM: RowViewModel = RowViewModel.init(model: RowModel(key: key, value: value!))
            weatherInfolistVM.append(rowVM)
        }
        name = model?.name
    }
}
