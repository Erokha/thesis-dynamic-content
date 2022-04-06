//
//  TDCEdgeConstaintDTO.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation

struct TDCEdgeConstaintDTO: Decodable {
    let edge: EdgeType
    let value: ConstaintValue
    
    enum ConstaintValue {
        case relative(RelativeConstaintData)
        case unknown
    }
    
    enum EdgeType: String {
        case topEdge = "top"
        case bottomEdge = "bottom"
        case unknown
    }
    
    struct RelativeConstaintData: Decodable {
        let id: TDCViewID?
        let edge: EdgeType
        let constant: Float?
        
        private enum CodingKeys: String, CodingKey {
            case id
            case edge
            case constant
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.id = try? container.decode(String.self, forKey: .id)
            let rawEdge = try container.decode(String.self, forKey: .edge)
            self.edge = EdgeType(rawValue: rawEdge) ?? .unknown
            self.constant = try? container.decode(Float.self, forKey: .constant)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case valueType = "value_type"
        case edge
    }
}

extension TDCEdgeConstaintDTO {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let valueType = try container.decode(String.self, forKey: .valueType)
        let rawEdge = try container.decode(String.self, forKey: .edge)
        let edge = EdgeType(rawValue: rawEdge) ?? .unknown
        
        switch valueType {
        case "relative":
            let relativeData = try RelativeConstaintData(from: decoder)
            self = .init(edge: edge, value: .relative(relativeData))
        default:
            self = .init(edge: edge, value: .unknown)
        }
    }
}

/*
 {
    "type": "edge",
    "edge": "top"
    "value-type": "relative"
    "id": "some_view_id"
    "edge": "bottom"
    "constant": 5
 }
 
*/
