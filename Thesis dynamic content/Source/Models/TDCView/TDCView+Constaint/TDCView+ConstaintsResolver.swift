//
//  TDCView+Constaints.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation
import UIKit

extension TDCView: TDCConstaintResolver {
    func resolve(edgeConstaint: TDCEdgeConstaint) {
        //TODO: Implement apply edgeConstaint
        return
    }
    
    func resolve(sizeConstaint: TDCSizeConstaint) {
        switch sizeConstaint.type {
        case .width:
            applyWidthConstaint(sizeConstaint)
        case .height:
            applyHeightConstaint(sizeConstaint)
        }
    }
    
    func resolve(sideConstaint: TDCSideConstaint) {
        //TODO: Implement apply sideConstaint
        return
    }
}

// MARK: - TDCView + SizeConstaint
extension TDCView {
    private func applyHeightConstaint(_ constaint: TDCSizeConstaint) {
        switch constaint.value {
        case .absoulte(let value):
            self.UIView
                .heightAnchor
                .constraint(equalToConstant: CGFloat(value))
                .isActive = true
        }
    }
    
    private func applyWidthConstaint(_ constaint: TDCSizeConstaint) {
        switch constaint.value {
        case .absoulte(let value):
            self.UIView
                .widthAnchor
                .constraint(equalToConstant: CGFloat(value))
                .isActive = true
        }
    }
}



