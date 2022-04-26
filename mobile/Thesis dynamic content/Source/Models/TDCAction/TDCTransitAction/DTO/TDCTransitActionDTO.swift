import Foundation

struct TDCTransitActionDTO: Decodable {
    let newURL: String
}

extension TDCTransitActionDTO {
    private enum CodingKeys: String, CodingKey {
        case newURL = "new_url"
    }
}
