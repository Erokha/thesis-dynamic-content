//
//  TDCView.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/3/22.
//

import Foundation

struct TDCBaseViewDTO: Decodable {
    let id: TDCViewID
    let configuration: TDCBaseViewConfigurationDTO
    let subviews: [TDCViewDTO]
    let constraints: [TDCConstraintDTO]
}
