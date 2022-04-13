//
//  TDCSize.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation

struct TDCSizeConstraintDTO: Decodable {
    let type: SizeType
    let value: ConstraintValue
    
    enum ConstraintValue {
        case absoulte(AbsoluteConstraintData)
        case unknown
    }
    
    enum SizeType: String {
        case height = "height"
        case width = "width"
        case unknown
    }
    
    struct AbsoluteConstraintData: Decodable {
        let value: Float
    }
    
    private enum CodingKeys: String, CodingKey {
        case sizeType = "size_type"
        case value
    }
}

extension TDCSizeConstraintDTO {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let rawType = try container.decode(String.self, forKey: .sizeType)
        let type = SizeType(rawValue: rawType) ?? .unknown
        let value = try container.decode(ConstraintValue.self, forKey: .value)
        
        self = .init(type: type, value: value)
    }
}

extension TDCSizeConstraintDTO.ConstraintValue: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(String.self, forKey: .type)
        
        switch valueType {
        case "absolute":
            let absoulteData = try TDCSizeConstraintDTO.AbsoluteConstraintData(from: decoder)
            self = .absoulte(absoulteData)
        default:
            self = .unknown
        }
    }
}

/*
    {
        "type": "size",
        "size_type": "height",
        "value": {
            "type": "absoulte",
            "value": 30,
        }
    }
*/
