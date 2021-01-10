//
//  FetchWeatherInfoProtocol.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 02/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

typealias WeatherInfoCompletion = (WeatherInfoModel?, String?) -> Void

protocol WeatherInfoFetcherProtocol {
    func fetchWeatherInfo(_ data: Data?, completion: WeatherInfoCompletion)
}
