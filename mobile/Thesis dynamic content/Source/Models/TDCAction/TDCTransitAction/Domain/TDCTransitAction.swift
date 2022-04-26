import Foundation

struct TDCTransitAction {
    let newURL: String
}

extension TDCTransitAction {
    init(from dto: TDCTransitActionDTO) {
        self.newURL = dto.newURL
    }
}
