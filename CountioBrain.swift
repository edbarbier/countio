//
//  CountioBrain.swift
//  Countio
//
//  Created by Edouard Barbier on 05/10/15.
//  Copyright © 2015 Edouard Barbier. All rights reserved.
//

import Foundation
import UIKit


class CountioBrain {
 
    func generateRandomNumber(currentResult: Int, currentOperation: String) -> Int {
        
        var randomNumber = 0
        
        if currentOperation == "-" {
            randomNumber = randNextValue(1, upper: currentResult - 1)
        } else {
            
            randomNumber = randNextValue(1, upper: 20)
        }
        
        return randomNumber
    }
    
    func randNextValue(lower: Int , upper: Int) -> Int {
        
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
        
        
    }
    
    
}


