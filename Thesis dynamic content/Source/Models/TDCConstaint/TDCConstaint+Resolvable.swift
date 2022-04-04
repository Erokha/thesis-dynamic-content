//
//  TDCConstaintProtocol.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation
import UIKit

protocol TDCConstaintResolver {
    func resolve(edgeConstaint: TDCEdgeConstaint)
    func resolve(sizeConstaint: TDCSizeConstaint)
    func resolve(sideConstaint: TDCSideConstaint)
}

protocol TDCConstaintResolvable {
    func resolve(using resolver: TDCConstaintResolver)
}
