import Foundation

enum TDCAction {
    case alert(TDCAlertAction)
    case transit(TDCTransitAction)
}

extension TDCAction {
    init?(from dto: TDCActionDTO) {
        switch dto {
        case .alert(let payload):
            self = .alert(TDCAction.convertAlertAction(from: payload))
        case .transit(let payload):
            self = .transit(TDCTransitAction(from: payload))
        case .unknown(let type):
            debugPrint("unable to convert to domain dto with type: \(type)")
            return nil
        }
    }
}

extension TDCAction {
    private static func convertAlertAction(from dto: TDCAlertActionDTO) -> TDCAlertAction {
        return TDCAlertAction(
            title: dto.title,
            message: dto.message,
            options: dto.options.map {
                TDCAlertAction.AlertActionOption(
                    title: $0.title,
                    handler: $0.action.flatMap{ TDCAction.init(from: $0) }
                )
            }
        )
    }
}
