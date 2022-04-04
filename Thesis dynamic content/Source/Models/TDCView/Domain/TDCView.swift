//
//  TDCView.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/3/22.
//

import Foundation

struct TDCView {
    let configuration: TDCViewConfiguration
}

extension TDCView {
    init(from dto: TDCViewDTO) {
        self.configuration = TDCViewConfiguration.init(from: dto.configuration)
    }
}
