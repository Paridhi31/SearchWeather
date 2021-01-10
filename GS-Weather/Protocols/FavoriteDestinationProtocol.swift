//
//  FetchUserDefaultsDataProtocol.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 03/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

protocol FavoriteDestinationProtocol {
    func fetchDestinationsFromUserDefaults() -> Set<String>? 
    func addDestinationInUserDefaults(destination: String)
    func deleteDestinationFromUserDefaults(destination: String)
    func isDestinationAlreadyFavorited(destination: String) -> Bool
}
