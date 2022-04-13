//
//  TDCViewConstraint.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation
import UIKit

struct TDCSizeConstraint {
    let type: ConstraintType
    let value: ConstraintValue
    
    enum ConstraintType {
        case height
        case width
    }
    
    enum ConstraintValue {
        case absoulte(Float)
    }
}
