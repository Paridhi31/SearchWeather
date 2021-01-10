//
//  BaseRequestProtocol.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 02/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

protocol BaseRequestProtocol {
    
    typealias Response = WeatherResponse

    var url: String? { get }
    var endPoint: String? { get set }
    var method: String? { get set }
    var parameters: [AnyHashable: Any]?  { get set }
    
    var jsonParserBlock: JSONParserBlock? { get set }
    var jsonErrorBlock: JSONErrorBlock? { get set }
}
