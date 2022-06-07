import Foundation
import UIKit

enum TDCConstraint {
    case edge(TDCEdgeConstraint)
    case size(TDCSizeConstraint)
    case side(TDCSideConstraint)
}
