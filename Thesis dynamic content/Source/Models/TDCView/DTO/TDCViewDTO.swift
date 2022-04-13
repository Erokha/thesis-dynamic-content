//
//  TDCView.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/3/22.
//

import Foundation

struct TDCViewDTO: Decodable {
    let id: TDCViewID
    let configuration: TDCViewConfigurationDTO
    let subviews: [TDCViewDTO]
    let constraints: [TDCConstraintDTO]
}
