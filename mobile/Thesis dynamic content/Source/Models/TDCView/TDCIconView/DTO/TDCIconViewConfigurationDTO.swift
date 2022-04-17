import Foundation

struct TDCIconViewConfigurationDTO: Decodable {
    enum ContentScaleType: String {
        case scaleAspectFill = "scale_aspect_fill"
        case scaleToFill = "scale_to_fill"
        case normal = "normal"
        case unknown
    }
    
    let cornerRadius: Int?
    let color: String?
    let contentScaleType: ContentScaleType?
    let imageURL: String
    let onTapAction: TDCActionDTO?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.cornerRadius = try? container.decode(Int.self, forKey: .cornerRadius)
        self.color = try? container.decode(String.self, forKey: .color)
        let rawScaleType = try? container.decode(String.self, forKey: .contentScaleType)
        self.onTapAction = try? container.decode(TDCActionDTO.self, forKey: .onTapAction)
        self.contentScaleType = ContentScaleType(rawValue: rawScaleType ?? "") ?? .unknown
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
    }
}

extension TDCIconViewConfigurationDTO {
    enum CodingKeys: String, CodingKey {
        case cornerRadius = "corner_radius"
        case color
        case contentScaleType = "content_scale_type"
        case imageURL = "image_url"
        case onTapAction = "on_tap_action"
    }
}
