import Foundation

struct TDCViewConverterSteward {
    func covert(dto: TDCViewDTO) -> TDCViewProtocol? {
        switch dto.value {
        case .TDCBaseViewDTO(let payload):
            return TDCBaseView(from: payload)
        case .TDCTextViewDTO(let payload):
            return TDCTextView(from: payload)
        case .TDCIconViewDTO(let payload):
            return TDCIconView(from: payload)
        case .TDCStackView(let payload):
            return TDCStackView(from: payload)
        case .unknown:
            return nil
        }
    }
}
