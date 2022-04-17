import Foundation
import UIKit

public typealias TDCViewID = String

class TDCBaseView: TDCViewProtocol {

    // MARK: - Public properties
    let id: TDCViewID
    private(set) var subviews: [TDCViewProtocol]
    weak var superview: TDCViewProtocol?
    var UIView: UIView = {
        let view = UIKit.UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Private properties
    
    private var configuration: TDCBaseViewConfiguration
    
    private var constraints: [TDCConstraint]
    
    private lazy var gestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.addTarget(self, action: #selector(callAction))
        return gestureRecognizer
    }()
    
    var invoker: TDCActionInvokerProxy? {
        didSet {
            subviews.forEach { $0.invoker = invoker }
        }
    }
    
    
    // MARK: - Init
    init(from dto: TDCBaseViewDTO) {
        let constraintConverter = TDCConstraintDTOToDomainConverter()
        self.id = dto.id
        self.configuration = TDCBaseViewConfiguration.init(from: dto.configuration)
        self.constraints = dto.constraints.compactMap { constraintConverter.convert(dto: $0) }
        self.subviews = dto.subviews.compactMap { TDCViewConverterSteward().covert(dto: $0) }
        
        self.subviews.forEach { $0.superview = self }
        applyConfiguration()
    }
    
    // MARK: - Public methods
    
    func addSubview(_ subview: TDCBaseView) {
        subview.superview = self
        subviews.append(subview)
    }
    
    func applyConstraints() {
        constraints.forEach { apply(constraint: $0) }
    }
    
    // MARK: - Private methods
    
    private func applyConfiguration() {
        if let color = configuration.color {
            UIView.backgroundColor = color
        }
        
        if let cornerRadius = configuration.cornerRadius {
            UIView.layer.cornerRadius = CGFloat(cornerRadius)
            UIView.clipsToBounds = true
        }
        
        UIView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func callAction() {
        invoker?.invoke(action: configuration.onTapAction)
    }
}
