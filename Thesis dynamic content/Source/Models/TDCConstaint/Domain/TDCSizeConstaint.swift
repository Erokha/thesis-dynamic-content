//
//  TDCViewConstaint.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation
import UIKit

struct TDCSizeConstaint {
    let type: ConstaintType
    let value: ConstaintValue
    
    enum ConstaintType {
        case height
        case width
    }
    
    enum ConstaintValue {
        case absoulte(Float)
    }
}

extension TDCSizeConstaint: TDCConstaintResolvable {
    func resolve(using resolver: TDCConstaintResolver) {
        resolver.resolve(sizeConstaint: self)
    }
}
