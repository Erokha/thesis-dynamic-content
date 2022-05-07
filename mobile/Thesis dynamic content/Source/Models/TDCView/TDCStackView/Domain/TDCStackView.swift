import Foundation
import UIKit

class TDCStackView: TDCViewProtocol {
    var id: TDCViewID
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var UIView: UIView { scrollView }
    
    var invoker: TDCActionInvokerProxy? {
        didSet {
            subviews.forEach { $0.invoker = invoker }
        }
    }
    
    var subviews: [TDCViewProtocol]
    
    var superview: TDCViewProtocol?
    
    private let configuration: TDCStackViewConfiguration
    
    private var constraints: [TDCConstraint]
    
    func applyConstraints() {
        constraints.forEach { apply(constraint: $0) }
    }
    
    func layout(on view: UIView) {
        setup()
        
        subviews.forEach {
            $0.superview = self
            self.stackView.addArrangedSubview($0.UIView)
        }
        self.applyConstraints()
        subviews.forEach {
            $0.layout(on: self.stackView)
            $0.applyConstraints()
        }
    }
    
    private func setup() {
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    // MARK: - Init
    init(from dto: TDCStackViewDTO) {
        let constraintConverter = TDCConstraintDTOToDomainConverter()
        self.id = dto.id
        self.configuration = TDCStackViewConfiguration.init(from: dto.configuration)
        self.constraints = dto.constraints.compactMap { constraintConverter.convert(dto: $0) }
        self.subviews = dto.subviews.compactMap { TDCViewConverterSteward().covert(dto: $0) }
        
        self.subviews.forEach { $0.superview = self }
        applyConfiguration()
    }
    
    private func applyConfiguration() {
        switch configuration.direction {
        case .vertical:
            stackView.axis = .vertical
        case .horizontal:
            stackView.axis = .horizontal
        }
        
        if let spacing = configuration.spacing {
            stackView.spacing = CGFloat(spacing)
        }
        
        stackView.alignment = .center
    }
    
}
