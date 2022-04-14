//
//  TDCTextViewDTO.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/14/22.
//

import Foundation

struct TDCTextViewDTO: Decodable {
    let id: TDCViewID
    let configuration: TDCTextViewConfigurationDTO
    let subviews: [TDCBaseViewDTO]
    let constraints: [TDCConstraintDTO]
}
