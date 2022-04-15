import Foundation
import UIKit

struct TDCEdgeConstraint {
    let edge: ConstraintType
    let value: ConstraintValue
    
    enum ConstraintType {
        case topEdge
        case bottomEdge
    }
    
    enum ConstraintValue {
        case relative(RelativeConstraintData)
    }
    
    struct RelativeConstraintData {
        let id: TDCViewID?
        let edge: ConstraintType
        let constant: Float?
    }
}
