//
//  TDCConstaint.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation
import UIKit

struct TDCEdgeConstaint {
    let edge: ConstaintEdge
    let value: ConstaintEdge
    
    enum ConstaintEdge {
        case topEdge
        case bottomEdge
    }
    
    enum ConstaintValue {
        case absoulte(Float)
    }
    
    struct RelativeConstaintData {
        let id: TDCViewID
        let edge: ConstaintEdge
        let constant: Float?
    }
}


extension TDCEdgeConstaint: TDCConstaintResolvable {
    func resolve(using resolver: TDCConstaintResolver) {
        resolver.resolve(edgeConstaint: self)
    }
}

