import Foundation
import UIKit

protocol TDCViewProtocol: AnyObject {
    typealias LayoutCompletion = (() -> Void)
    func apply(constraint: TDCConstraint)
    var id: TDCViewID { get }
    var UIView: UIView { get }
    var invoker: TDCActionInvokerProxy? { get set }
    var sameLevelViews: [TDCViewProtocol] { get }
    var subviews: [TDCViewProtocol] { get }
    var superview: TDCViewProtocol? { get set }
    
    
    func applyConstraints()
    func layout(on view: UIView)
}

extension TDCViewProtocol {
    var sameLevelViews: [TDCViewProtocol] {
        guard let superview = superview else {
            return []
        }
        return superview.subviews
    }
    
    func layout(on view: UIView) {
        subviews.forEach {
            $0.superview = self
            self.UIView.addSubview($0.UIView)
        }
        self.applyConstraints()
        subviews.forEach {
            $0.layout(on: self.UIView)
            $0.applyConstraints()
        }
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
        guard let superView = UIView.superview else {
            return
        }
        applyTopConstraint(constraint, to: superView)
    }
    
    private func applyRelativeViewTopConstraint(_ constraint: TDCEdgeConstraint.RelativeConstraintData) {
        guard let id = constraint.id else {
            applySuperviewTopConstraint(constraint)
            return
        }
        guard let relativeView = sameLevelViews.first(where: { $0.id == id }) else {
            return
        }
        applyTopConstraint(constraint, to: relativeView.UIView)
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
        applyBottomConstraint(constraint, to: superView)
    }
    
    private func applyRelativeViewBottomConstraint(_ constraint: TDCEdgeConstraint.RelativeConstraintData) {
        guard let id = constraint.id else {
            applySuperviewBottomConstraint(constraint)
            return
        }
        guard let relativeView = sameLevelViews.first(where: { $0.id == id }) else {
            return
        }
        applyBottomConstraint(constraint, to: relativeView.UIView)
    }
    
    private func applyTopConstraint(
        _ constraint: TDCEdgeConstraint.RelativeConstraintData,
        to view: UIView
    ) {
        switch constraint.edge {
        case .topEdge:
            self.UIView
                .topAnchor
                .constraint(
                    equalTo: view.topAnchor,
                    constant: constraint.constant.flatMap { CGFloat($0) } ?? 0
                ).isActive = true
        case .bottomEdge:
            self.UIView
                .topAnchor
                .constraint(
                    equalTo: view.bottomAnchor,
                    constant: constraint.constant.flatMap { CGFloat($0) } ?? 0
                ).isActive = true
        }
    }
    
    private func applyBottomConstraint(
        _ constraint: TDCEdgeConstraint.RelativeConstraintData,
        to view: UIView
    ) {
        switch constraint.edge {
        case .topEdge:
            self.UIView
                .bottomAnchor
                .constraint(
                    equalTo: view.topAnchor,
                    constant: constraint.constant.flatMap { CGFloat($0) } ?? 0
                ).isActive = true
        case .bottomEdge:
            self.UIView
                .bottomAnchor
                .constraint(
                    equalTo: view.bottomAnchor,
                    constant: constraint.constant.flatMap { CGFloat($0) } ?? 0
                ).isActive = true
        }
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
        guard let superView = UIView.superview else {
            return
        }
        applyLeftConstraint(relative, to: superView)
    }
    
    private func applyRelativeViewLeftConstraint(_ relative: TDCSideConstraint.RelativeConstraintData) {
        guard let id = relative.id else {
            applySuperviewLeftConstraint(relative)
            return
        }
        guard let relativeView = sameLevelViews.first(where: { $0.id == id }) else {
            return
        }
        applyLeftConstraint(relative, to: relativeView.UIView)
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
        guard let superView = UIView.superview else {
            return
        }
        applyRightConstraint(relative, to: superView)
    }
    
    private func applyRelativeViewRightConstraint(_ relative: TDCSideConstraint.RelativeConstraintData) {
        guard let id = relative.id else {
            applySuperviewRightConstraint(relative)
            return
        }
        guard let relativeView = sameLevelViews.first(where: { $0.id == id }) else {
            return
        }
        applyRightConstraint(relative, to: relativeView.UIView)
    }
    
    private func applyLeftConstraint(
        _ constraint: TDCSideConstraint.RelativeConstraintData,
        to view: UIView
    ) {
        switch constraint.side {
        case .ledftSide:
            self.UIView
                .leftAnchor
                .constraint(
                    equalTo: view.leftAnchor,
                    constant: constraint.constant.flatMap { CGFloat($0) } ?? 0
                ).isActive = true
        case .rightSide:
            self.UIView
                .leftAnchor
                .constraint(
                    equalTo: view.rightAnchor,
                    constant: constraint.constant.flatMap { CGFloat($0) } ?? 0
                ).isActive = true
        }
    }
    
    private func applyRightConstraint(
        _ constraint: TDCSideConstraint.RelativeConstraintData,
        to view: UIView
    ) {
        switch constraint.side {
        case .ledftSide:
            self.UIView
                .rightAnchor
                .constraint(
                    equalTo: view.leftAnchor,
                    constant: constraint.constant.flatMap { CGFloat($0) } ?? 0
                ).isActive = true
        case .rightSide:
            self.UIView
                .rightAnchor
                .constraint(
                    equalTo: view.rightAnchor,
                    constant: constraint.constant.flatMap { CGFloat($0) } ?? 0
                ).isActive = true
        }
    }
}
