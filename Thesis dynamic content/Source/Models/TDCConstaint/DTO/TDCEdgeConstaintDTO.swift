//
//  TDCEdgeConstraintDTO.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation

struct TDCEdgeConstraintDTO: Decodable {
    let edge: EdgeType
    let value: ConstraintValue
    
    enum ConstraintValue {
        case relative(RelativeConstraintData)
        case unknown
    }
    
    enum EdgeType: String {
        case topEdge = "top"
        case bottomEdge = "bottom"
        case unknown
    }
    
    struct RelativeConstraintData {
        let id: TDCViewID?
        let edge: EdgeType
        let constant: Float?
    }
    
    private enum CodingKeys: String, CodingKey {
        case edge
        case value
    }
}

extension TDCEdgeConstraintDTO {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let rawEdge = try container.decode(String.self, forKey: .edge)
        let edge = EdgeType(rawValue: rawEdge) ?? .unknown
        let value = try container.decode(ConstraintValue.self, forKey: .value)
        
        self = .init(edge: edge, value: value)
    }
}

extension TDCEdgeConstraintDTO.ConstraintValue: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(String.self, forKey: .type)
        
        switch valueType {
        case "relative":
            let relativeData = try TDCEdgeConstraintDTO.RelativeConstraintData(from: decoder)
            self = .relative(relativeData)
        default:
            self = .unknown
        }
    }
}

extension TDCEdgeConstraintDTO.RelativeConstraintData {
    private enum CodingKeys: String, CodingKey {
        case id
        case edge
        case constant
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decode(String.self, forKey: .id)
        let rawEdge = try container.decode(String.self, forKey: .edge)
        self.edge = TDCEdgeConstraintDTO.EdgeType(rawValue: rawEdge) ?? .unknown
        self.constant = try? container.decode(Float.self, forKey: .constant)
    }
}

/*
    {
        "type": "edge",
        "edge": "top",
        "value": {
            "type": "relative",
            "id": "some_view_id",
            "edge": "bottom",
            "constant": 5
        }
    }
*/
