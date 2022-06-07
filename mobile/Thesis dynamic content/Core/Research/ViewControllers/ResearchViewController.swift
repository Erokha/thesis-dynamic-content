import Foundation
import UIKit

final class ResearchViewController: UIViewController {
    private var tdcView: TDCViewProtocol? = nil
    private lazy var invoker: TDCActionInvokerProxy = {
        TDCActionInvokerProxy(delegateViewController: self)
    }()
    
    private let demoView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutDemoView()
    }
    
    
    func layoutData(data: TDCViewProtocol) {
        self.demoView.addSubview(data.UIView)
        data.layout(on: demoView)
    }
    
    private func layoutDemoView() {
        view.addSubview(demoView)
        demoView.clipsToBounds = true
        demoView.backgroundColor = .red
        demoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            demoView.topAnchor.constraint(equalTo: view.topAnchor),
            demoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            demoView.rightAnchor.constraint(equalTo: view.rightAnchor),
            demoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
}

extension ResearchViewController: TDCActionInvokerDelegate {
    func showAlert(_ alert: TDCAlertAction) {
        let alertController = UIAlertController(
            title: alert.title,
            message: alert.message,
            preferredStyle: .alert
        )
        let actions = alert
            .options
            .map { option in
                return UIAlertAction(
                    title: option.title,
                    style: .default,
                    handler: { [weak self] _ in
                        self?.invoker.invoke(action: option.handler)
                    }
                )
            }
        actions.forEach { alertController.addAction($0) }
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func performTransit(_ transit: TDCTransitAction) {
        // do nothing
        return
    }
    
    
}
