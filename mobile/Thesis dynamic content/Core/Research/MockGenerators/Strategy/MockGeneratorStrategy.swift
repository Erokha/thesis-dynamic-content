import Foundation

protocol MockViewGeneratorStrategy {
    /// Just generate data. This time WILL NOT BE MEASURE in tests
    func generateMockData(numberOfViews: Int)
    /// Create View/ViewController with generated data. This time WILL BE MEASURED in tests
    /// - Returns: View, that sould be loaded
    func loadViewWithData() -> TDCViewProtocol
}
