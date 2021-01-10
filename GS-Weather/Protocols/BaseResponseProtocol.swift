//
//  BaseResponseProtocol.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 02/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

protocol BaseResponseProtocol {
    associatedtype Response
    associatedtype ResponseError
    
    var data: Response? {get set}
    var error: ResponseError? {get set}
}
