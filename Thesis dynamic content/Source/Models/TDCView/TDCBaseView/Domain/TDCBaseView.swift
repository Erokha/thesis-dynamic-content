//
//  TDCView.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/3/22.
//

import Foundation
import UIKit

public typealias TDCViewID = String

class TDCBaseView: TDCViewProtocol {

    // MARK: - Public properties
    let id: TDCViewID
    private(set) var subviews: [TDCViewProtocol]
    weak var superview: TDCViewProtocol?
    var UIView: UIView = {
        let view = UIKit.UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Private properties
    
    private var configuration: TDCBaseViewConfiguration
    
    private var constraints: [TDCConstraint]
    
    
    // MARK: - Init
    init(from dto: TDCBaseViewDTO) {
        let constraintConverter = TDCConstraintDTOToDomainConverter()
        self.id = dto.id
        self.configuration = TDCBaseViewConfiguration.init(from: dto.configuration)
        self.constraints = dto.constraints.compactMap { constraintConverter.convert(dto: $0) }
        self.subviews = dto.subviews.compactMap { TDCViewConverterSteward().covert(dto: $0) }
        
        self.subviews.forEach { $0.superview = self }
        applyConfiguration()
    }
    
    // MARK: - Public methods
    
    func addSubview(_ subview: TDCBaseView) {
        subview.superview = self
        subviews.append(subview)
    }
    
    func applyConstraints() {
        constraints.forEach { apply(constraint: $0) }
    }
    
    func layout(on view: UIView) {
        view.addSubview(self.UIView)
        subviews.forEach { $0.layout(on: self.UIView) }
        self.applyConstraints()
    }
    
    // MARK: - Private methods
    
    private func applyConfiguration() {
        if let color = configuration.color {
            UIView.backgroundColor = color
        }
        
        if let cornerRadius = configuration.cornerRadius {
            UIView.layer.cornerRadius = CGFloat(cornerRadius)
            UIView.clipsToBounds = true
        }
    }

}
