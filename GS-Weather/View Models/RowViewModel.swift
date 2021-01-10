//
//  RowViewModel.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 05/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

class RowViewModel {
    var key: String?
    var value: String?
    
    init(model: RowModel) {
        self.key = model.key
        self.value = model.value
    }
}
