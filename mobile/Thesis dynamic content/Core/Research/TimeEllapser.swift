import Foundation

struct TimeEllapser {
    typealias ClosureBlock = (() -> Void)
    
    let nonEllapsedPrepareBlock: ClosureBlock?
    let block: ClosureBlock
    let nonEllapsedFinalizerBlock: ClosureBlock?
    
    init(
        nonEllapsedPrepareBlock: ClosureBlock?,
        _ block: @escaping ClosureBlock,
        nonEllapsedFinalizerBlock: ClosureBlock?
    ) {
        self.nonEllapsedPrepareBlock = nonEllapsedPrepareBlock
        self.block = block
        self.nonEllapsedFinalizerBlock = nonEllapsedFinalizerBlock
    }
    
    func calculateTime(avarageOf numberOfRepeats: Int = 10) -> Double {
        var sum: Double = 0
        for _ in 0..<numberOfRepeats {
            nonEllapsedPrepareBlock?()
            sum += singleEllapse(block)
            nonEllapsedFinalizerBlock?()
        }
        return sum / Double(numberOfRepeats)
    }
    
    private func singleEllapse(_ block: ClosureBlock) -> Double {
        let start = Date()
        block()
        return -start.timeIntervalSinceNow
    }
    
}
