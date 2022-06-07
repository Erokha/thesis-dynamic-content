import Foundation
import UIKit

final class TDCTextView: TDCViewProtocol {
    var id: TDCViewID
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var UIView: UIView { label }
    
    var subviews: [TDCViewProtocol]
    
    weak var superview: TDCViewProtocol?
    
    var invoker: TDCActionInvokerProxy? {
        didSet {
            subviews.forEach { $0.invoker = invoker }
        }
    }
    
    let constraints: [TDCConstraint]
    
    let configuration: TDCTextViewConfiguration
    
    init(from dto: TDCTextViewDTO) {
        let constraintConverter = TDCConstraintDTOToDomainConverter()
        self.id = dto.id
        self.configuration = TDCTextViewConfiguration.init(from: dto.configuration)
        self.constraints = dto.constraints.compactMap { constraintConverter.convert(dto: $0) }
        self.subviews = dto.subviews.compactMap { TDCViewConverterSteward().covert(dto: $0) }
        
        self.subviews.forEach { $0.superview = self }
        applyConfiguration()
    }
    
    func applyConstraints() {
        constraints.forEach { apply(constraint: $0) }
    }
    
    private func applyConfiguration() {
        if let arrangenment = configuration.arrangenment {
            switch arrangenment {
            case .left:
                label.textAlignment = .left
            case .right:
                label.textAlignment = .right
            case .center:
                label.textAlignment = .center
            }
        }
        
        if let textSize = configuration.textSize {
            label.font = UIFont.systemFont(ofSize: CGFloat(textSize))
        }
        
        if let color = configuration.textColor {
            label.textColor = color
        }
        
        label.text = configuration.text
    }
    
}
