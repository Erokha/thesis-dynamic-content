//
//  TDCViewConfiguration.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/3/22.
//

import Foundation

struct TDCViewConfigurationDTO: Codable {
    let color: String?
    let cornerRadius: Int?
}

extension TDCViewConfigurationDTO {
    enum CodingKeys: String, CodingKey {
        case color
        case cornerRadius = "corner_radius"
    }
}
