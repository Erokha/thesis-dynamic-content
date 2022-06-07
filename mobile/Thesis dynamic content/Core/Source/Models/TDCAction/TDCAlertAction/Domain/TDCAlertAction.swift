import Foundation

final class TDCAlertAction {
    struct AlertActionOption {
        let title: String
        let handler: TDCAction?
    }
    
    let title: String
    let message: String
    let options: [AlertActionOption]
    
    init(
        title: String,
        message: String,
        options: [AlertActionOption]
    ) {
        self.title = title
        self.message = message
        self.options = options
    }
}
