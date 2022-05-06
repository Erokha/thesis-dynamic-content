import Foundation

struct TDCStackViewDTO: Decodable {
    let id: TDCViewID
    let configuration: TDCStackViewConfigurationDTO
    let subviews: [TDCViewDTO]
    let constraints: [TDCConstraintDTO]
}
