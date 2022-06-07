import Foundation

struct TDCStackViewConfigurationDTO: Decodable {
    
    let shouldShowScroll: Bool?
    let spacing: Int?
    
    enum CodingKeys: String, CodingKey {
        case shouldShowScroll = "should_show_scroll"
        case spacing
    }
}
