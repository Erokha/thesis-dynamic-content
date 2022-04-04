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
    init(from dto: TDCViewDTO) {
        self.id = dto.id
        self.configuration = TDCViewConfiguration.init(from: dto.configuration)
        self.constraints = []
        self.subviews = dto.subviews.map { TDCView(from: $0) }
    }
    
    let id: TDCViewID
    let configuration: TDCViewConfiguration
    var constraints: [TDCConstaintResolvable]
    let subviews: [TDCView]
    
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
    
    func applyConstraints() {
        constraints.forEach { $0.resolve(using: self) }
    }
}
