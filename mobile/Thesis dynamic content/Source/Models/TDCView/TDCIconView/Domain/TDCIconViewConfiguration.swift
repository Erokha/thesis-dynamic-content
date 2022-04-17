import Foundation
import UIKit

struct TDCIconViewConfiguration {
    enum ContentScaleType {
        case scaleAspectFill
        case scaleToFill
        case normal
    }
    
    let cornerRadius: Int?
    let color: UIColor?
    let contentScaleType: ContentScaleType
    let imageURL: String
    let onTapAction: TDCAction?
}

extension TDCIconViewConfiguration {
    init(from dto: TDCIconViewConfigurationDTO) {
        self.cornerRadius = dto.cornerRadius
        self.color = dto.color.flatMap { UIColor(hex: $0) }
        self.contentScaleType = dto.contentScaleType.flatMap {
            ContentScaleType.init(with: $0)
        } ?? .normal
        self.imageURL = dto.imageURL
        self.onTapAction = dto.onTapAction.flatMap { TDCAction.init(from: $0) }
    }
}

extension TDCIconViewConfiguration.ContentScaleType {
    init(with dto: TDCIconViewConfigurationDTO.ContentScaleType) {
        switch dto {
        case .scaleAspectFill:
            self = .scaleAspectFill
        case .scaleToFill:
            self = .scaleToFill
        case .normal:
            self = .normal
        case .unknown:
            self = .normal
        }
    }
}
