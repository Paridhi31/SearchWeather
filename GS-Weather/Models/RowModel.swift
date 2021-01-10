//
//  RowModel.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 06/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation

struct RowModel {
    var key: String?
    var value: String?
    
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}
