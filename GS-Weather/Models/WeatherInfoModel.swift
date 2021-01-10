//
//  WeatherInfoModel.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 02/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

let kKEY_FEELS_LIKE = "feels_like"
let kKEY_HUMIDITY = "humidity"
let kKEY_TEMP = "temp"
let kKEY_MAX_TEMP = "temp_max"
let kKEY_MIN_TEMP = "temp_min"

class WeatherInfoModel {
    
    var weatherDetailsDict: [String: String?] = [:]
    var name: String?
    
    public init(data: Data?) {
        if let data = data {
            let json: [AnyHashable: Any?]? = try? JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable : Any?]
            if let json = json {
                let mainDict: [AnyHashable: Any]? = json["main"] as? [AnyHashable : Any]
                weatherDetailsDict["Feels Like"] = "\(mainDict?[kKEY_FEELS_LIKE] ?? "-")"
                weatherDetailsDict["Humidity"] = "\(mainDict?[kKEY_HUMIDITY] ?? "-")"
                weatherDetailsDict["Temperature"] = "\(mainDict?[kKEY_TEMP] ?? "-")"
                weatherDetailsDict["Maximum temperature"] = "\(mainDict?[kKEY_MAX_TEMP] ?? "-")"
                weatherDetailsDict["Minimum temperature"] = "\(mainDict?[kKEY_MIN_TEMP] ?? "-")"

                name = json["name"] as? String
            }
        }
    }
}

struct WeatherResponse: BaseResponseProtocol {
    var data: WeatherInfoModel?
    var error: ServiceError?
}
