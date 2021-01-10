//
//  GSErrorCodes.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 03/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

enum GSErrorCodes: Error {
    
    case GSFileNotFoundErrorCode
    case GSInternalServerErrorCode
    case GSAuthorizationErrorCode
    case GSNoCityData
    case GSUnknownError
    
    func errorDescription() -> String {
        switch self {
        case .GSFileNotFoundErrorCode:
            return "City not found"
            
        case .GSInternalServerErrorCode:
            return "Error occurred"
            
        case .GSAuthorizationErrorCode:
            return "Unauthorized user"
            
        case .GSNoCityData:
            return "Please enter the city"

        default:
            return "Unknown error"
        }
    }
}

