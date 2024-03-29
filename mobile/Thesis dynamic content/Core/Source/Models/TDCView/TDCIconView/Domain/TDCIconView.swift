import Foundation
import UIKit

final class TDCIconView: TDCViewProtocol {
    var id: TDCViewID
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var UIView: UIView { imageView }
    
    var subviews: [TDCViewProtocol]
    
    weak var superview: TDCViewProtocol?
    
    let constraints: [TDCConstraint]
    
    var invoker: TDCActionInvokerProxy? {
        didSet {
            subviews.forEach { $0.invoker = invoker }
        }
    }
    
    let configuration: TDCIconViewConfiguration
    
    init(from dto: TDCIconViewDTO) {
        let constraintConverter = TDCConstraintDTOToDomainConverter()
        self.id = dto.id
        self.configuration = TDCIconViewConfiguration.init(from: dto.configuration)
        self.constraints = dto.constraints.compactMap { constraintConverter.convert(dto: $0) }
        self.subviews = dto.subviews.compactMap { TDCViewConverterSteward().covert(dto: $0) }
        
        self.subviews.forEach { $0.superview = self }
        applyConfiguration()
    }
    
    func applyConstraints() {
        constraints.forEach { apply(constraint: $0) }
    }
    
    private func applyConfiguration() {
        ImageService().loadImage(with: configuration.imageURL) { response in
            switch response {
            case .success(let image):
                self.imageView.image = image
            case .failure(let error):
                debugPrint(error)
            }
        }
        
        switch configuration.contentScaleType {
        case .scaleAspectFill:
            imageView.contentMode = .scaleAspectFill
        case .scaleToFill:
            imageView.contentMode = .scaleToFill
        case .normal:
            imageView.contentMode = .center
        }
        
        if let cornerRadius = configuration.cornerRadius {
            imageView.layer.cornerRadius = CGFloat(cornerRadius)
        }
        
        if let color = configuration.color {
            imageView.backgroundColor = color
        }
        
    }
    
}
