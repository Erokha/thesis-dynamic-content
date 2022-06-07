import Foundation

struct TDCStackViewConfiguration {
    
    let spacing: Int?
    let shouldShowScroll: Bool
}

extension TDCStackViewConfiguration {
    init(from dto: TDCStackViewConfigurationDTO) {
        self.spacing = dto.spacing
        self.shouldShowScroll = dto.shouldShowScroll ?? true
    }
}
