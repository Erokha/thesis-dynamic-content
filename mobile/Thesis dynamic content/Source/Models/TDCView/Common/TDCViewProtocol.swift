//
//  TDCView+Constraints.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation
import UIKit

protocol TDCViewProtocol: AnyObject {
    func apply(constraint: TDCConstraint)
    var id: TDCViewID { get }
    var UIView: UIView { get }
    var sameLevelViews: [TDCViewProtocol] { get }
    var subviews: [TDCViewProtocol] { get }
    var superview: TDCViewProtocol? { get set }
    
    func layout(on view: UIView)
}

extension TDCViewProtocol {
    var sameLevelViews: [TDCViewProtocol] {
        guard let superview = superview else {
            return []
        }
        return superview
            .subviews
            .filter { $0.id != self.id }
    }
}

extension TDCViewProtocol {
    func apply(constraint: TDCConstraint) {
        switch constraint {
        case .edge(let payload):
            apply(edgeConstraint: payload)
        case .side(let payload):
            apply(sideConstraint: payload)
        case .size(let payload):
            apply(sizeConstraint: payload)
        }
    }
    
    private func apply(edgeConstraint: TDCEdgeConstraint) {
        switch edgeConstraint.edge {
        case .bottomEdge:
            applyBottomConstraint(edgeConstraint)
        case .topEdge:
            applyTopConstraint(edgeConstraint)
        }
        return
    }
    
    private func apply(sizeConstraint: TDCSizeConstraint) {
        switch sizeConstraint.type {
        case .width:
            applyWidthConstraint(sizeConstraint)
        case .height:
            applyHeightConstraint(sizeConstraint)
        }
    }
    
    private func apply(sideConstraint: TDCSideConstraint) {
        switch sideConstraint.side {
        case .ledftSide:
            applyLeftConstraint(sideConstraint)
        case .rightSide:
            applyRightConstraint(sideConstraint)
        }
        return
    }
}

// MARK: - TDCView + SizeConstraint
extension TDCViewProtocol {
    private func applyHeightConstraint(_ constraint: TDCSizeConstraint) {
        switch constraint.value {
        case .absoulte(let value):
            self.UIView
                .heightAnchor
                .constraint(equalToConstant: CGFloat(value))
                .isActive = true
        }
    }
    
    private func applyWidthConstraint(_ constraint: TDCSizeConstraint) {
        switch constraint.value {
        case .absoulte(let value):
            self.UIView
                .widthAnchor
                .constraint(equalToConstant: CGFloat(value))
                .isActive = true
        }
    }
}

// MARK: - TDCView + Edge
extension TDCViewProtocol {
    private func applyTopConstraint(_ constraint: TDCEdgeConstraint) {
        switch constraint.value {
        case .relative(let relativeData):
            if let _ = relativeData.id {
                applyRelativeViewTopConstraint(relativeData)
            } else {
                applySuperviewTopConstraint(relativeData)
            }
        }
    }
    
    private func applySuperviewTopConstraint(_ constraint: TDCEdgeConstraint.RelativeConstraintData) {
        guard let superView = self.UIView.superview else {
            return
        }
        switch constraint.edge {
        case .topEdge:
            self.UIView
                .topAnchor
                .constraint(equalTo: superView.topAnchor, constant: constraint.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        case .bottomEdge:
            self.UIView
                .topAnchor
                .constraint(equalTo: superView.bottomAnchor, constant: constraint.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        }
    }
    
    private func applyRelativeViewTopConstraint(_ constraint: TDCEdgeConstraint.RelativeConstraintData) {
        //TODO: Implement apply applyRelativeViewTopConstraint with searching view by id
    }
    
    private func applyBottomConstraint(_ constraint: TDCEdgeConstraint) {
        switch constraint.value {
        case .relative(let relativeData):
            if let _ = relativeData.id {
                applyRelativeViewBottomConstraint(relativeData)
            } else {
                applySuperviewBottomConstraint(relativeData)
            }
        }
    }
    
    private func applySuperviewBottomConstraint(_ constraint: TDCEdgeConstraint.RelativeConstraintData) {
        guard let superView = self.UIView.superview else {
            return
        }
        switch constraint.edge {
        case .topEdge:
            self.UIView
                .bottomAnchor
                .constraint(equalTo: superView.topAnchor, constant: constraint.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        case .bottomEdge:
            self.UIView
                .bottomAnchor
                .constraint(equalTo: superView.bottomAnchor, constant: constraint.constant.flatMap { CGFloat($0) } ?? 0)
                .isActive = true
        }
        
    }
    
    private func applyRelativeViewBottomConstraint(_ constraint: TDCEdgeConstraint.RelativeConstraintData) {
        //TODO: Implement apply applyRelativeViewBottomConstraint with searching view by id
    }
}

// MARK: - TDCView + Side
extension TDCViewProtocol {
    private func applyLeftConstraint(_ constraint: TDCSideConstraint) {
        switch constraint.value {
        case .relative(let relativeData):
            if let _ = relativeData.id {
                applyRelativeViewLeftConstraint(relativeData)
            } else {
                applySuperviewLeftConstraint(relativeData)
            }
        }
    }
    
    private func applySuperviewLeftConstraint(_ relative: TDCSideConstraint.RelativeConstraintData) {
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
    
    private func applyRelativeViewLeftConstraint(_ relative: TDCSideConstraint.RelativeConstraintData) {
        //TODO: Implement apply applyRelativeViewLeftConstraint with searching view by id
    }
    
    private func applyRightConstraint(_ constraint: TDCSideConstraint) {
        switch constraint.value {
        case .relative(let relativeData):
            if let _ = relativeData.id {
                applyRelativeViewRightConstraint(relativeData)
            } else {
                applySuperviewRightConstraint(relativeData)
            }
        }
    }
    
    private func applySuperviewRightConstraint(_ relative: TDCSideConstraint.RelativeConstraintData) {
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
    
    private func applyRelativeViewRightConstraint(_ relative: TDCSideConstraint.RelativeConstraintData) {
        //TODO: Implement apply applyRelativeViewRightConstraint with searching view by id
    }
}
