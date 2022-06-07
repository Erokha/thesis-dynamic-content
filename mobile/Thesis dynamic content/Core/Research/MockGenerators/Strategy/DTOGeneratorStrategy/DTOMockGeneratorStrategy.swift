import Foundation

final class DTOMockGeneratorStrategy: MockViewGeneratorStrategy {
    
    var data: TDCViewDTO!
    
    func generateMockData(numberOfViews: Int) {
        let generator = DTOMockViewGenerator()
        data = generator.generateViewWith(numberOfSubviews: numberOfViews)
    }
    
    func loadViewWithData() -> TDCViewProtocol {
        return TDCViewConverterSteward().covert(dto: data)!
    }
    
    
}
