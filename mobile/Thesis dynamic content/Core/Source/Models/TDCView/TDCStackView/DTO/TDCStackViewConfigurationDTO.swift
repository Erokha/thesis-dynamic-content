import Foundation

struct TDCStackViewConfigurationDTO: Decodable {
    enum Direction: String {
        case vertical = "vertical"
        case horizontal = "horizontal"
        case unknown
    }
    
    let direction: Direction
    let spacing: Int?
    
    enum CodingKeys: String, CodingKey {
        case direction
        case spacing
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawDirection = try container.decode(String.self, forKey: .direction)
        self.direction = Direction(rawValue: rawDirection) ?? .unknown
        self.spacing = try? container.decode(Int.self, forKey: .spacing)
    }
}
