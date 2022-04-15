import UIKit

final class InitialViewController: UIViewController {
    
    private var tdcView: TDCViewProtocol? {
        didSet {
            tdcView?.layout(on: view)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        DispatchQueue.global().async {[weak self] in self?.requestView() }
    }
    
    private func requestView() {
        LayoutRequestService().requestPage(pageURI: "/main_view") { (response) in
            switch response {
            case .success(let data):
                let steward = TDCViewConverterSteward()
                let view = steward.covert(dto: data)
                self.tdcView = view
            case .failure:
                print("error")
            }
        }
    }

}
