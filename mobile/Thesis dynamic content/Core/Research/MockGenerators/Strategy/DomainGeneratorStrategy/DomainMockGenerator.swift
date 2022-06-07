import Foundation
import UIKit

class DomainMockViewGenerator {
    
    private var idCounter = 0
    
    init() {}
    
    func generateViewWith(numberOfSubviews: Int) -> TDCViewProtocol {
        var views: [TDCViewProtocol] = []
        for _ in 0..<numberOfSubviews {
            views.append(generateBaseView())
        }
        return generateFirstLayerView(subviews: views)
    }

    private func generateFirstLayerView(subviews: [TDCViewProtocol]) -> TDCBaseView {
        return TDCBaseView(
            id: "base",
            subviews: subviews,
            superview: nil,
            configuration: TDCBaseViewConfiguration(
                color: .yellow,
                cornerRadius: 0,
                onTapAction: nil
            ),
            constraints: [
                .edge(.init(edge: .topEdge, value: .relative(.init(id: nil, edge: .topEdge, constant: 0)))),
                .edge(.init(edge: .bottomEdge, value: .relative(.init(id: nil, edge: .bottomEdge, constant: 0)))),
                .side(.init(side: .ledftSide, value: .relative(.init(id: nil, side: .ledftSide, constant: 0)))),
                .side(.init(side: .rightSide, value: .relative(.init(id: nil, side: .rightSide, constant: 0)))),
            ],
            invoker: nil
        )
    }
    
    private func generateBaseView() -> TDCBaseView {
        let view = TDCBaseView(
            id: "\(idCounter)",
            subviews: [],
            superview: nil,
            configuration: TDCBaseViewConfiguration(
                color: randomColor(),
                cornerRadius: Int.random(in: 0...15),
                onTapAction: nil
            ),
            constraints: generateMockConstraits(),
            invoker: nil
        )
        idCounter += 1
        
        return view
    }
    
    private func generateMockConstraits() -> [TDCConstraint] {
        return [
            .size(randomHeightConstraint()),
            .size(randomWidthConstraint()),
            .edge(randomEdgeConstraint()),
            .side(randomSideConstraint())
        ]
    }
    
}

extension DomainMockViewGenerator {
    private func randomColor() -> UIColor {
        let array: [UIColor] = [.red, .blue, .black, .orange, .green, .cyan, .purple]
        return array.randomElement()!
    }
    private func randomHeightConstraint() -> TDCSizeConstraint {
        return TDCSizeConstraint(
            type: .height,
            value: .absoulte(Float.random(in: 50...150))
        )
    }
    
    private func randomWidthConstraint() -> TDCSizeConstraint {
        return TDCSizeConstraint(
            type: .width,
            value: .absoulte(Float.random(in: 50...150))
        )
    }
    
    private func randomSideConstraint() -> TDCSideConstraint {
        typealias Side = TDCSideConstraint.ConstraintType
        let side: Side = [Side.ledftSide, Side.rightSide].randomElement()!
        let constant = Float.random(in: 0...300) * (side == .ledftSide ? 1 : -1)
        
        return TDCSideConstraint(
            side: side,
            value: .relative(
                TDCSideConstraint.RelativeConstraintData(
                    id: nil,
                    side: side,
                    constant: constant
                )
            )
        )
    }
    
    private func randomEdgeConstraint() -> TDCEdgeConstraint {
        typealias Edge = TDCEdgeConstraint.ConstraintType
        let edge: Edge = [Edge.topEdge, Edge.bottomEdge].randomElement()!
        let constant = Float.random(in: 0...300) * (edge == .topEdge ? 1 : -1)
        
        return TDCEdgeConstraint(
            edge: edge,
            value: .relative(
                TDCEdgeConstraint.RelativeConstraintData(
                    id: nil,
                    edge: edge,
                    constant: constant
                )
            )
        )
    }
    
    
}
