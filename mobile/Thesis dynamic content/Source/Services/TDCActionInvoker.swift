import Foundation
import UIKit

protocol TDCActionInvokerDelegate: AnyObject {
    func showAlert(_ alert: TDCAlertAction)
    func performTransit(_ transit: TDCTransitAction)
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
        case .transit(let payload):
            invokeTransit(payload)
        }
    }
    
    private func invokeAlert(_ payload: TDCAlertAction) {
        delegateViewController?.showAlert(payload)
    }
    
    private func invokeTransit(_ payload: TDCTransitAction) {
        delegateViewController?.performTransit(payload)
    }
}
