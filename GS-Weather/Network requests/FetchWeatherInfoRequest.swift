//
//  FetchWeatherInfoRequest.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 02/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

class FetchWeatherInfoRequest: BaseRequestProtocol {
    
    var url: String?
    
    var endPoint: String?
    
    var method: String?
    
    var parameters: [AnyHashable : Any]?
    
    var jsonParserBlock: JSONParserBlock?
    
    var jsonErrorBlock: JSONErrorBlock?
}
