import Foundation

enum TDCConstraintDTO: Decodable {
    
    case edge(TDCEdgeConstraintDTO)
    case side(TDCSideConstraintDTO)
    case size(TDCSizeConstraintDTO)
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
            let edge = try TDCEdgeConstraintDTO(from: decoder)
            self = .edge(edge)
        case ConstraintType.side.rawValue:
            let side = try TDCSideConstraintDTO(from: decoder)
            self = .side(side)
        case ConstraintType.size.rawValue:
            let size = try TDCSizeConstraintDTO(from: decoder)
            self = .size(size)
        default:
            self = .unknown
        }
    }
}
