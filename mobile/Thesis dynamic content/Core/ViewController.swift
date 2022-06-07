import UIKit

final class InitialViewController: UIViewController {
    private var tdcView: TDCViewProtocol? = nil
    private lazy var invoker: TDCActionInvokerProxy = makeInvoker()
    
    private let demoView = UIView()
    private let reloadButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        layoutReloadButton()
        layoutDemoView()
    }
    
    private func layoutDemoView() {
        view.addSubview(demoView)
        demoView.clipsToBounds = true
        demoView.backgroundColor = .white
        demoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            demoView.topAnchor.constraint(equalTo: view.topAnchor),
            demoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            demoView.rightAnchor.constraint(equalTo: view.rightAnchor),
            demoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override var canBecomeFirstResponder: Bool { true }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == .motionShake {
            requestView(for: "http:/localhost:5000/main_view")
        }
    }
    
//    private func layoutReloadButton() {
//        view.addSubview(reloadButton)
//        reloadButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            reloadButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
//            reloadButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            reloadButton.widthAnchor.constraint(equalToConstant: 70),
//            reloadButton.heightAnchor.constraint(equalToConstant: 25)
//        ])
//        reloadButton.backgroundColor = .blue
//        reloadButton.clipsToBounds = true
//        reloadButton.layer.cornerRadius = 8
//        reloadButton.setTitleColor(.white, for: .normal)
//        reloadButton.setTitle("Reload", for: .normal)
//        reloadButton.addTarget(self, action: #selector(requestView), for: .touchUpInside)
//    }
}

extension InitialViewController: TDCActionInvokerDelegate {
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
        requestView(for: transit.newURL)
    }
    
    
}


extension InitialViewController {
    
    private func makeInvoker() -> TDCActionInvokerProxy {
        return TDCActionInvokerProxy(delegateViewController: self)
    }
    
    @objc
    private func requestView(for url: String) {
        let steward = TDCViewConverterSteward()
        let service = LayoutRequestService()
        service.requestPage(fullURL: url) {[weak self] (response) in
            switch response {
            case .success(let data):
                guard
                    let newTdcView = steward.covert(dto: data),
                    let self = self
                else {
                    debugPrint("unable to convert tdcview from dto")
                    return
                }
                self.clearDemoView()
                self.demoView.addSubview(newTdcView.UIView)
                newTdcView.layout(on: self.demoView)
                newTdcView.invoker = self.invoker
                self.tdcView = newTdcView
            case .failure:
                print("error")
            }
        }
    }
    
    private func clearDemoView() {
        self.demoView.subviews.forEach { $0.removeFromSuperview() }
    }
}
