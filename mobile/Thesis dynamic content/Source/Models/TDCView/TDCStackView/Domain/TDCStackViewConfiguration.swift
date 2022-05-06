import Foundation

struct TDCStackViewConfiguration {
    enum Direction: String {
        case vertical
        case horizontal
    }
    
    let direction: Direction
    let spacing: Int?
}

extension TDCStackViewConfiguration {
    init(from dto: TDCStackViewConfigurationDTO) {
        switch dto.direction {
        case .vertical:
            self.direction = .vertical
        case .horizontal:
            self.direction = .horizontal
        case .unknown:
            self.direction = .vertical
        }
        self.spacing = dto.spacing 
    }
}
