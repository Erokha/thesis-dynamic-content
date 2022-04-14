//
//  TDCIconViewDTO.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/14/22.
//

import Foundation

struct TDCIconViewDTO: Decodable {
    let id: TDCViewID
    let configuration: TDCIconViewConfigurationDTO
    let subviews: [TDCViewDTO]
    let constraints: [TDCConstraintDTO]
}
