//
//  TDCEdgeConstraint.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation

struct TDCSideConstraint {
    let side: ConstraintType
    let value: ConstraintValue
    
    enum ConstraintType {
        case ledftSide
        case rightSide
    }
    
    enum ConstraintValue {
        case relative(RelativeConstraintData)
    }
    
    struct RelativeConstraintData {
        let id: TDCViewID?
        let side: ConstraintType
        let constant: Float?
    }
}
