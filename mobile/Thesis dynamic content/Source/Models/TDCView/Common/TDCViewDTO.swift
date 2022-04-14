//
//  TDCViewDTO.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/14/22.
//

import Foundation



struct TDCViewDTO: Decodable {
    enum ViewType: Decodable {
        case TDCBaseViewDTO(TDCBaseViewDTO)
        case TDCTextViewDTO(TDCTextViewDTO)
        case TDCIconViewDTO(TDCIconViewDTO)
        case unknown
    }
    
    let type: String
    let value: ViewType
    
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.type = try container.decode(String.self, forKey: .type)
        switch type {
        case "base_view":
            let payload = try TDCBaseViewDTO.init(from: decoder)
            self.value = .TDCBaseViewDTO(payload)
        case "text_view":
            let payload = try TDCTextViewDTO(from: decoder)
            self.value = .TDCTextViewDTO(payload)
        case "icon_view":
            let payload = try TDCIconViewDTO(from: decoder)
            self.value = .TDCIconViewDTO(payload)
        default:
            self.value = .unknown
        }
    }
    
}
