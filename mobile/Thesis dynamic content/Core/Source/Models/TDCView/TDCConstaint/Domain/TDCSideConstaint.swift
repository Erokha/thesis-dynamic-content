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
