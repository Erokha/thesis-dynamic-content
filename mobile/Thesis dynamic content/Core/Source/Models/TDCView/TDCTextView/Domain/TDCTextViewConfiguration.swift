import Foundation
import UIKit

struct TDCTextViewConfiguration {
    enum TDCTextViewArrangenment {
        case left
        case right
        case center
    }
    
    let textColor: UIColor?
    let textSize: Int?
    let arrangenment: TDCTextViewArrangenment?
    let text: String
    let onTapAction: TDCAction?
}

extension TDCTextViewConfiguration {
    init(from dto: TDCTextViewConfigurationDTO) {
        self.textColor = dto.textColor.flatMap { UIColor(hex: $0) }
        self.textSize = dto.textSize
        self.arrangenment = .init(with: dto.arrangenment)
        self.text = dto.text
        self.onTapAction = dto.onTapAction.flatMap { TDCAction.init(from: $0) }
    }
}

extension TDCTextViewConfiguration.TDCTextViewArrangenment {
    init(with dto: TDCTextViewConfigurationDTO.TDCTextViewArrangenmentDTO) {
        switch dto {
        case .left:
            self = .left
        case .right:
            self = .right
        case .center:
            self = .center
        case .unknown:
            self = .left
        }
    }
}
