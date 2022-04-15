import Foundation

struct TDCBaseViewConfigurationDTO: Decodable {
    let color: String?
    let cornerRadius: Int?
}

extension TDCBaseViewConfigurationDTO {
    enum CodingKeys: String, CodingKey {
        case color
        case cornerRadius = "corner_radius"
    }
}
