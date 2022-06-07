import Foundation

struct TDCTextViewDTO: Decodable {
    let id: TDCViewID
    let configuration: TDCTextViewConfigurationDTO
    let subviews: [TDCViewDTO]
    let constraints: [TDCConstraintDTO]
}
