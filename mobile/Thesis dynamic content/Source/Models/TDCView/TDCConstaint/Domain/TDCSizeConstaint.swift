import Foundation
import UIKit

struct TDCSizeConstraint {
    let type: ConstraintType
    let value: ConstraintValue
    
    enum ConstraintType {
        case height
        case width
    }
    
    struct RelativeConstraintValue {
        enum ConstantType {
            case multiplier(Float)
            case constaint(Int)
        }
        
        let id: TDCViewID?
        let type: ConstraintType
        let value: ConstantType
    }
    
    enum ConstraintValue {
        case absoulte(Float)
        case relative(RelativeConstraintValue)
    }
}
