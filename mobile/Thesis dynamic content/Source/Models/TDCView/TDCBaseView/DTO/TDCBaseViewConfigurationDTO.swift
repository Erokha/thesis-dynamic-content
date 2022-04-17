import Foundation

struct TDCBaseViewConfigurationDTO: Decodable {
    let color: String?
    let cornerRadius: Int?
    let onTapAction: TDCActionDTO?
}

extension TDCBaseViewConfigurationDTO {
    enum CodingKeys: String, CodingKey {
        case color
        case cornerRadius = "corner_radius"
        case onTapAction = "on_tap_action"
    }
}
