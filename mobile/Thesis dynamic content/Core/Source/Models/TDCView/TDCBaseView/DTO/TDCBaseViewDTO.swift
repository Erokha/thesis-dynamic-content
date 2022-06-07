import Foundation

struct TDCBaseViewDTO: Decodable {
    let id: TDCViewID
    let configuration: TDCBaseViewConfigurationDTO
    let subviews: [TDCViewDTO]
    let constraints: [TDCConstraintDTO]
}
