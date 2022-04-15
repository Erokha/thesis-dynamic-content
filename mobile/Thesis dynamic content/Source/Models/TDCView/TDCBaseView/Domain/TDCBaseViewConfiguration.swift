import Foundation
import UIKit

struct TDCBaseViewConfiguration {
    let color: UIColor?
    let cornerRadius: Int?
}

extension TDCBaseViewConfiguration {
    init(from dto: TDCBaseViewConfigurationDTO) {
        self.color = dto.color.flatMap { UIColor(hex: $0) }
        self.cornerRadius = dto.cornerRadius
    }
}
