//
//  TDCSideConstaintDTO.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation

struct TDCSideConstaintDTO: Decodable {
    let side: SideType
    let value: ConstaintValue
    
    enum ConstaintValue {
        case relative(RelativeConstaintData)
        case unknown
    }
    
    enum SideType: String {
        case leftSide = "left"
        case rightSide = "right"
        case unknown
    }
    
    struct RelativeConstaintData {
        let id: TDCViewID?
        let side: SideType
        let constant: Float?
    }
    
    private enum CodingKeys: String, CodingKey {
        case side
        case value
    }
}

extension TDCSideConstaintDTO {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let rawSide = try container.decode(String.self, forKey: .side)
        let side = SideType(rawValue: rawSide) ?? .unknown
        let value = try container.decode(ConstaintValue.self, forKey: .value)
        
        self = .init(side: side, value: value)
    }
}

extension TDCSideConstaintDTO.ConstaintValue: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(String.self, forKey: .type)
        
        switch valueType {
        case "relative":
            let relativeData = try TDCSideConstaintDTO.RelativeConstaintData(from: decoder)
            self = .relative(relativeData)
        default:
            self = .unknown
        }
    }
}

extension TDCSideConstaintDTO.RelativeConstaintData {
    private enum CodingKeys: String, CodingKey {
        case id
        case side
        case constant
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decode(String.self, forKey: .id)
        let rawSide = try container.decode(String.self, forKey: .side)
        self.side = TDCSideConstaintDTO.SideType(rawValue: rawSide) ?? .unknown
        self.constant = try? container.decode(Float.self, forKey: .constant)
    }
}

/*
    {
        "type": "side",
        "side": "left",
        "value": {
            "type": "relative",
            "id": "some_view_id",
            "side": "right",
            "constant": 5
        }
    }
*/
