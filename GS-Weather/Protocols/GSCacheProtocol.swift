//
//  GSCacheProtocol.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 10/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

protocol GSCacheProtocol {
    func addInfoInCacheFor(destination: NSString, data: WeatherInfoModel)
    func getCachedInfoFor(destination: NSString) -> WeatherInfoModel?
    
    var weatherInfoCache: NSCache<NSString, WeatherInfoModel> {get set}
}
