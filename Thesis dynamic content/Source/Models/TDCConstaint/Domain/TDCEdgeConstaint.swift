//
//  TDCConstaint.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation
import UIKit

struct TDCEdgeConstaint {
    let edge: ConstaintType
    let value: ConstaintValue
    
    enum ConstaintType {
        case topEdge
        case bottomEdge
    }
    
    enum ConstaintValue {
        case relative(RelativeConstaintData)
    }
    
    struct RelativeConstaintData {
        let id: TDCViewID?
        let edge: ConstaintType
        let constant: Float?
    }
}


extension TDCEdgeConstaint: TDCConstaintResolvable {
    func resolve(using resolver: TDCConstaintResolver) {
        resolver.resolve(edgeConstaint: self)
    }
}
