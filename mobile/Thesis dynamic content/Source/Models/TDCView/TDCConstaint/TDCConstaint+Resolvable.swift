//
//  TDCConstraintProtocol.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//



import Foundation
import UIKit

enum TDCConstraint {
    case edge(TDCEdgeConstraint)
    case size(TDCSizeConstraint)
    case side(TDCSideConstraint)
}
