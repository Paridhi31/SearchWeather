//
//  ApplicationDefines.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 02/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation
import UIKit

let WEATHER_API_KEY = "4122b8c50cc6d3289f2635bc6db92788"

typealias JSONParserBlock = (_ data: Data?) -> Void

typealias JSONErrorBlock = (_ error: String?) -> Void

let KGET_METHOD: String = "GET"

let kKEY_MAIN = "main"

let FETCH_WEATHER_BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
