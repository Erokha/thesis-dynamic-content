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
