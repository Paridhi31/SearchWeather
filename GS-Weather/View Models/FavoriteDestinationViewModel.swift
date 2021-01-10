//
//  FavoriteDestinationViewModel.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 03/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import UIKit

class FavoriteDestinationViewModel {
    
    var cellViewModelArray: [FavoriteDestinationCellVM]?
    
    init() {
        loadData()
    }
    
    func loadData() {
        let destinations: Set<String>? = FavoriteDestinationManager().fetchDestinationsFromUserDefaults()
        if let destinations = destinations {
            cellViewModelArray = destinations.map { FavoriteDestinationCellVM(destination: $0) }
        }
    }
    
    
    func removeFromFavorite(at index: Int) {
        let destinationVM = cellViewModelArray?[index]
        if let destination = destinationVM?.destination {
            FavoriteDestinationManager().deleteDestinationFromUserDefaults(destination: destination)
        }
        cellViewModelArray?.remove(at: index)
    }
}
