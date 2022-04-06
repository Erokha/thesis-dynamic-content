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
        switch edgeConstaint.edge {
        case .bottomEdge:
            applyBottomConstaint(edgeConstaint)
        case .topEdge:
            applyTopConstraint(edgeConstaint)
        }
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
        switch sideConstaint.side {
        case .ledftSide:
            applyLeftConstraint(sideConstaint)
        case .rightSide:
            applyRightConstraint(sideConstaint)
        }
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

// MARK: - TDCView + Edge
extension TDCView {
    private func applyTopConstraint(_ constaint: TDCEdgeConstaint) {
        switch constaint.value {
        case .relative(let relativeData):
            if let _ = relativeData.id {
                applyRelativeViewTopConstraint(relativeData)
            } else {
                applySuperviewTopConstraint(relativeData)
            }
        }
    }
    
    private func applySuperviewTopConstraint(_ constaint: TDCEdgeConstaint.RelativeConstaintData) {
        guard let superView = self.UIView.superview else {
            return
        }
        switch constaint.edge {
        case .topEdge:
            self.UIView
                .topAnchor
                .constraint(equalTo: superView.topAnchor, constant: constaint.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        case .bottomEdge:
            self.UIView
                .topAnchor
                .constraint(equalTo: superView.bottomAnchor, constant: constaint.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        }
    }
    
    private func applyRelativeViewTopConstraint(_ constaint: TDCEdgeConstaint.RelativeConstaintData) {
        //TODO: Implement apply applyRelativeViewTopConstraint with searching view by id
    }
    
    private func applyBottomConstaint(_ constaint: TDCEdgeConstaint) {
        switch constaint.value {
        case .relative(let relativeData):
            if let _ = relativeData.id {
                applyRelativeViewBottomConstraint(relativeData)
            } else {
                applySuperviewBottomConstraint(relativeData)
            }
        }
    }
    
    private func applySuperviewBottomConstraint(_ constaint: TDCEdgeConstaint.RelativeConstaintData) {
        guard let superView = self.UIView.superview else {
            return
        }
        switch constaint.edge {
        case .topEdge:
            self.UIView
                .bottomAnchor
                .constraint(equalTo: superView.topAnchor, constant: constaint.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        case .bottomEdge:
            self.UIView
                .bottomAnchor
                .constraint(equalTo: superView.bottomAnchor, constant: constaint.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        }
        
    }
    
    private func applyRelativeViewBottomConstraint(_ constaint: TDCEdgeConstaint.RelativeConstaintData) {
        //TODO: Implement apply applyRelativeViewBottomConstraint with searching view by id
    }
}

// MARK: - TDCView + Side
extension TDCView {
    private func applyLeftConstraint(_ constaint: TDCSideConstaint) {
        switch constaint.value {
        case .relative(let relativeData):
            if let _ = relativeData.id {
                applyRelativeViewLeftConstraint(relativeData)
            } else {
                applySuperviewLeftConstraint(relativeData)
            }
        }
    }
    
    private func applySuperviewLeftConstraint(_ relative: TDCSideConstaint.RelativeConstaintData) {
        guard let superView = self.UIView.superview else {
            return
        }
        switch relative.side {
        case .ledftSide:
            self.UIView
                .leftAnchor
                .constraint(equalTo: superView.leftAnchor, constant: relative.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        case .rightSide:
            self.UIView
                .leftAnchor
                .constraint(equalTo: superView.rightAnchor, constant: relative.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        }
    }
    
    private func applyRelativeViewLeftConstraint(_ relative: TDCSideConstaint.RelativeConstaintData) {
        //TODO: Implement apply applyRelativeViewLeftConstraint with searching view by id
    }
    
    private func applyRightConstraint(_ constaint: TDCSideConstaint) {
        switch constaint.value {
        case .relative(let relativeData):
            if let _ = relativeData.id {
                applyRelativeViewRightConstraint(relativeData)
            } else {
                applySuperviewRightConstraint(relativeData)
            }
        }
    }
    
    private func applySuperviewRightConstraint(_ relative: TDCSideConstaint.RelativeConstaintData) {
        guard let superView = self.UIView.superview else {
            return
        }
        switch relative.side {
        case .ledftSide:
            self.UIView
                .rightAnchor
                .constraint(equalTo: superView.leftAnchor, constant: relative.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        case .rightSide:
            self.UIView
                .rightAnchor
                .constraint(equalTo: superView.rightAnchor, constant: relative.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        }
    }
    
    private func applyRelativeViewRightConstraint(_ relative: TDCSideConstaint.RelativeConstaintData) {
        //TODO: Implement apply applyRelativeViewRightConstraint with searching view by id
    }
}
