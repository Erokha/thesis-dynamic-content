import Foundation

final class DomainMockGeneratorStrategy: MockViewGeneratorStrategy {
    
    var data: TDCViewProtocol!
    
    func generateMockData(numberOfViews: Int) {
        let generator = DomainMockViewGenerator()
        data = generator.generateViewWith(numberOfSubviews: numberOfViews)
    }
    
    func loadViewWithData() -> TDCViewProtocol {
        return data
    }
    
    
}
