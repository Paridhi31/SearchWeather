//
//  AlertHandler.swift
//  GS-Weather
//
//  Created by Paridhi Malviya on 10/01/21.
//  Copyright © 2021 Paridhi Malviya. All rights reserved.
//

import Foundation
import UIKit

class AlertHandler {
    
    func showErrorAlertWith(header: String, message: String, buttonText: String) -> UIAlertController {
        let alertController = UIAlertController(title: header, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))
        return alertController
    }
}
