import Foundation

struct TDCAlertActionDTO: Decodable {
    
    struct AlertActionOption: Decodable {
        let title: String
        let action: TDCActionDTO?
    }
    
    let title: String
    let message: String
    let options: [AlertActionOption]
}
