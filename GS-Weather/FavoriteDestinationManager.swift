//
//  UserDefaultsManager.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 03/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

let kKEY_FAVORITE_DESTINATION = "fav_destinations"

struct FavoriteDestinationManager: FavoriteDestinationProtocol {
    func isDestinationAlreadyFavorited(destination: String) -> Bool {
        let destinations = unarchiveDestinations() ?? Set<String>()
        return destinations.contains(destination)
    }
    
    func fetchDestinationsFromUserDefaults() -> Set<String>? {
        let destinations = unarchiveDestinations() ?? Set<String>()
        return destinations
    }
    
    func addDestinationInUserDefaults(destination: String) {
        var destinations = unarchiveDestinations() ?? Set<String>()
        destinations.insert(destination)
        archiveDestinationsAndSave(destinations: destinations)
    }
    
    func deleteDestinationFromUserDefaults(destination: String) {
        let destinations = unarchiveDestinations()
        if var destinations = destinations {
            let index = destinations.firstIndex(of: destination)
            if let index = index {
                destinations.remove(at: index)
            }
            archiveDestinationsAndSave(destinations: destinations)
        }
    }
}

private extension FavoriteDestinationManager {
    func archiveDestinationsAndSave(destinations: Set<String>) {
        do {
            let userDefaults = UserDefaults.standard
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: destinations, requiringSecureCoding: false)
            userDefaults.set(encodedData, forKey: kKEY_FAVORITE_DESTINATION)
        } catch {
            print("Exception in archiving")
        }
    }
    
    func unarchiveDestinations() -> Set<String>? {
        let userDefaults = UserDefaults.standard
        let data  = userDefaults.object(forKey: kKEY_FAVORITE_DESTINATION) as? Data
        if let data = data {
            do {
                let destinations = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Set<String>
                return destinations
            } catch {
                print("Exception in unarchiving")
            }
        }
        return nil
    }
}
