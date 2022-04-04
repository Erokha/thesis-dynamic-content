//
//  TDCConstaintDTO.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation

enum TDCConstraintDTO: Decodable {
    
    case edge(TDCEdgeConstaintDTO)
    case side(TDCSideConstaintDTO)
    case size(TDCSizeConstaintDTO)
    case unknown
    
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    enum ConstraintType: String {
        case edge = "edge"
        case size = "size"
        case side = "side"
    }
}

extension TDCConstraintDTO {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case ConstraintType.edge.rawValue:
            //TODO: - TDCEdgeConstaintDTO
            let edge = try TDCEdgeConstaintDTO(from: decoder)
            self = .edge(edge)
        case ConstraintType.side.rawValue:
            //TODO: - TDCSideConstaintDTO
            let side = try TDCSideConstaintDTO(from: decoder)
            self = .side(side)
        case ConstraintType.size.rawValue:
            //TODO: - TDCSizeConstaintDTO
            let size = try TDCSizeConstaintDTO(from: decoder)
            self = .size(size)
        default:
            self = .unknown
        }
    }
}
