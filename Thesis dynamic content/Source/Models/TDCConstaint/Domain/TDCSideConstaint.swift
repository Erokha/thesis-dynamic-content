//
//  TDCEdgeConstaint.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation

struct TDCSideConstaint {
    let side: ConstaintType
    let value: ConstaintValue
    
    enum ConstaintType {
        case ledftSide
        case rightSide
    }
    
    enum ConstaintValue {
        case relative(RelativeConstaintData)
    }
    
    struct RelativeConstaintData {
        let id: TDCViewID?
        let side: ConstaintType
        let constant: Float?
    }
}

extension TDCSideConstaint: TDCConstaintResolvable {
    func resolve(using resolver: TDCConstaintResolver) {
        resolver.resolve(sideConstaint: self)
    }
}
