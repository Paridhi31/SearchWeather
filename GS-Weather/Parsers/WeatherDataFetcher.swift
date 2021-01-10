//
//  WeatherDataFetcher.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 02/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation


class WeatherDataFetcher: WeatherInfoFetcherProtocol {
    
    func fetchWeatherInfo(_ data: Data?, completion: WeatherInfoCompletion) {
        guard let data = data else {
            completion(nil, "Unknown reason")
            return
        }
        
        let weatherInfo = WeatherInfoModel.init(data: data)
        completion(weatherInfo, nil)
    }
}
