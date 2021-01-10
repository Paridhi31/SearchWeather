//
//  GSCacheManager.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 10/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto


class GSCacheManager: GSCacheProtocol {
    static let sharedInstance = GSCacheManager()
    
    private init() {}

    var weatherInfoCache: NSCache<NSString, WeatherInfoModel> = NSCache<NSString, WeatherInfoModel>()
    
    func addInfoInCacheFor(destination: NSString, data: WeatherInfoModel) {
        weatherInfoCache.setObject(data, forKey: destination)
    }
    
    func getCachedInfoFor(destination: NSString) -> WeatherInfoModel? {
        return weatherInfoCache.object(forKey: destination as NSString)
    }
}
