//
//  NetworkManagerProtocol.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 02/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    associatedtype T
    func enqueueRequest<T: BaseRequestProtocol>(_ request: T)
}
