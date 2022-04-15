import Foundation

struct TDCIconViewDTO: Decodable {
    let id: TDCViewID
    let configuration: TDCIconViewConfigurationDTO
    let subviews: [TDCViewDTO]
    let constraints: [TDCConstraintDTO]
}
