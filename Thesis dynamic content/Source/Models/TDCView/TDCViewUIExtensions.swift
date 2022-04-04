//
//  TDCViewUIExtensions.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/3/22.
//

import Foundation
import UIKit

extension TDCView {
    var UIView: UIView {
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
    }
}
