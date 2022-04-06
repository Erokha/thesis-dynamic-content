//
//  TDCSize.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/5/22.
//

import Foundation

struct TDCSizeConstaintDTO: Decodable {
    let type: SizeType
    let value: ConstaintValue
    
    enum ConstaintValue {
        case absoulte(AbsoluteConstaintData)
        case unknown
    }
    
    enum SizeType: String {
        case height = "height"
        case width = "width"
        case unknown
    }
    
    struct AbsoluteConstaintData: Decodable {
        let value: Float
    }
    
    private enum CodingKeys: String, CodingKey {
        case sizeType = "size_type"
        case value
    }
}

extension TDCSizeConstaintDTO {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let rawType = try container.decode(String.self, forKey: .sizeType)
        let type = SizeType(rawValue: rawType) ?? .unknown
        let value = try container.decode(ConstaintValue.self, forKey: .value)
        
        self = .init(type: type, value: value)
    }
}

extension TDCSizeConstaintDTO.ConstaintValue: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valueType = try container.decode(String.self, forKey: .type)
        
        switch valueType {
        case "absolute":
            let absoulteData = try TDCSizeConstaintDTO.AbsoluteConstaintData(from: decoder)
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
