import UIKit

final class InitialViewController: UIViewController {
    private var tdcView: TDCViewProtocol? = nil
    private lazy var invoker: TDCActionInvokerProxy = makeInvoker()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        DispatchQueue.global().async {
            [weak self] in self?.requestView()
        }
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
                self.view.addSubview(tdcView.UIView)
                tdcView.invoker = self.invoker
                tdcView.layout(on: self.view)
            case .failure:
                print("error")
            }
        }
    }
}
