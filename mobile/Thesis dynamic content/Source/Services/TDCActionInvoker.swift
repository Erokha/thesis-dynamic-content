import Foundation
import UIKit

protocol TDCActionInvokerDelegate: AnyObject {
    func showAlert(_ alert: TDCAlertAction)
}

final class TDCActionInvokerProxy {
    weak var delegateViewController: TDCActionInvokerDelegate?
    
    init(
        delegateViewController: TDCActionInvokerDelegate
    ) {
        self.delegateViewController = delegateViewController
    }
    
    func invoke(action: TDCAction?) {
        guard let action = action else {
            return
        }

        switch action {
        case .alert(let payload):
            invokeAlert(payload)
        }
    }
    
    private func invokeAlert(_ payload: TDCAlertAction) {
        delegateViewController?.showAlert(payload)
    }
}
