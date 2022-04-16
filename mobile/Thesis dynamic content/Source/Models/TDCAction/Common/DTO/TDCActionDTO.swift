import Foundation

enum TDCActionDTO {
    case alert(TDCAlertActionDTO)
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
        default:
            self = .unknown(type: type)
        }
    }
}


