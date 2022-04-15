import Foundation

struct TDCTextViewConfigurationDTO: Decodable {
    enum TDCTextViewArrangenmentDTO: String {
        case left = "left"
        case right = "right"
        case center = "center"
        case unknown
    }
    
    let textColor: String?
    let textSize: Int?
    let arrangenment: TDCTextViewArrangenmentDTO
    let text: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.textColor = try? container.decode(String.self, forKey: .textColor)
        self.textSize = try? container.decode(Int.self, forKey: .textSize)
        let rawArrangenment = try? container.decode(String.self, forKey: .arrangenment)
        self.arrangenment = TDCTextViewArrangenmentDTO(rawValue: rawArrangenment ?? "") ?? .unknown
        self.text = try container.decode(String.self, forKey: .text)
    }
}

extension TDCTextViewConfigurationDTO {
    enum CodingKeys: String, CodingKey {
        case textColor = "text_color"
        case textSize = "text_size"
        case arrangenment
        case text
    }
}
