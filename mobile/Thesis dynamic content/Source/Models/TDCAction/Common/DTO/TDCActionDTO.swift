import Foundation

enum TDCActionDTO {
    case alert(TDCAlertActionDTO)
    case transit(TDCTransitActionDTO)
    case unknown(type: String)
}

extension TDCActionDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        
        switch type {
        case "alert":
            let payload = try TDCAlertActionDTO(from: decoder)
            self = .alert(payload)
        case "transit":
            let payload = try TDCTransitActionDTO(from: decoder)
            self = .transit(payload)
        default:
            self = .unknown(type: type)
        }
    }
}
