import Foundation

struct TDCSizeConstraintDTO: Decodable {
    let type: SizeType
    let value: ConstraintValue
    
    enum ConstraintValue {
        case absoulte(AbsoluteConstraintData)
        case relative(RelativeConstraintData)
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
             
    struct RelativeConstraintData: Decodable {
        let id: String?
        let sizeType: TDCSizeConstraintDTO.SizeType
        let constant: Int?
        let multiplier: Float?
        
        enum CodingKeys: String, CodingKey {
            case id
            case sizeType = "size_type"
            case constant
            case multiplier
        }
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

extension TDCSizeConstraintDTO.SizeType: Decodable {
    private enum CodingKeys: String, CodingKey {
        case sizeType = "size_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let rawType = try container.decode(String.self, forKey: .sizeType)
        self = .init(rawValue: rawType) ?? .unknown
    }
}

extension TDCSizeConstraintDTO.RelativeConstraintData {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try? container.decode(String.self, forKey: .id)
        self.sizeType = try TDCSizeConstraintDTO.SizeType.init(from: decoder)
        self.constant = try? container.decode(Int.self, forKey: .constant)
        self.multiplier = try? container.decode(Float.self, forKey: .multiplier)
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
            let payload = try TDCSizeConstraintDTO.AbsoluteConstraintData(from: decoder)
            self = .absoulte(payload)
        case "relative":
            do {
            let payload = try TDCSizeConstraintDTO.RelativeConstraintData(from: decoder)
            self = .relative(payload)
            } catch {
                print(error)
                throw error
            }
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
