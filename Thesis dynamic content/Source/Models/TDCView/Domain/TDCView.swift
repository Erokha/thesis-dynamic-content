//
//  TDCView.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/3/22.
//

import Foundation
import UIKit

public typealias TDCViewID = String

class TDCView {

    // MARK: - Public properties
    let id: TDCViewID
    let subviews: [TDCView]
    var constraints: [TDCConstaintResolvable]
    weak var superview: TDCView?
    
    lazy var UIView: UIView = {
        let view = UIKit.UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let color = configuration.color {
            view.backgroundColor = color
        }
        
        if let cornerRadius = configuration.cornerRadius {
            view.layer.cornerRadius = CGFloat(cornerRadius)
            view.clipsToBounds = true
        }
        
        return view
    }()
    
    // MARK: - Private properties
    private let configuration: TDCViewConfiguration
    
    //MARK: - Init
    init(from dto: TDCViewDTO) {
        self.id = dto.id
        self.configuration = TDCViewConfiguration.init(from: dto.configuration)
        self.constraints = []
        self.subviews = dto.subviews.map { TDCView(from: $0) }
        self.subviews.forEach { $0.superview = self }
    }

}

extension TDCView {
    func applyConstraints() {
        constraints.forEach { $0.resolve(using: self) }
    }
    
    var sameLevelViews: [TDCView] {
        guard let superview = superview else {
            return []
        }
        return superview
            .subviews
            .filter { $0.id != self.id }
    }
}
