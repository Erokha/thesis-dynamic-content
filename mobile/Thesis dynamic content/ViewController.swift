import UIKit

final class InitialViewController: UIViewController {
    private var tdcView: TDCViewProtocol? = nil
    private lazy var invoker: TDCActionInvokerProxy = makeInvoker()
    
    private let demoView = UIView()
    private let reloadButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutDemoView()
        layoutReloadButton()
    }
    
    private func layoutDemoView() {
        view.addSubview(demoView)
        demoView.clipsToBounds = true
        demoView.backgroundColor = .red
        demoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            demoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            demoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            demoView.rightAnchor.constraint(equalTo: view.rightAnchor),
            demoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func layoutReloadButton() {
        view.addSubview(reloadButton)
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reloadButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadButton.widthAnchor.constraint(equalToConstant: 70),
            reloadButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        reloadButton.backgroundColor = .blue
        reloadButton.clipsToBounds = true
        reloadButton.layer.cornerRadius = 8
        reloadButton.setTitleColor(.white, for: .normal)
        reloadButton.setTitle("Reload", for: .normal)
        reloadButton.addTarget(self, action: #selector(requestView), for: .touchUpInside)
    }
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
    
    
}


extension InitialViewController {
    
    private func makeInvoker() -> TDCActionInvokerProxy {
        return TDCActionInvokerProxy(delegateViewController: self)
    }
    
    @objc
    private func requestView() {
        let steward = TDCViewConverterSteward()
        let service = LayoutRequestService()
        service.requestPage(pageURI: "/main_view") { (response) in
            switch response {
            case .success(let data):
                guard let tdcView = steward.covert(dto: data) else {
                    debugPrint("unable to convert tdcview from dto")
                    return
                }
                self.tdcView = tdcView
                self.demoView.addSubview(tdcView.UIView)
                tdcView.invoker = self.invoker
                tdcView.layout(on: self.demoView)
            case .failure:
                print("error")
            }
        }
    }
}
