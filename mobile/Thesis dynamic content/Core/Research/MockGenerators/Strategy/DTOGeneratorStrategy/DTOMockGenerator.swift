import Foundation
import UIKit

class DTOMockViewGenerator {
    
    private var idCounter = 0
    
    init() {}
    
    func generateViewWith(numberOfSubviews: Int) -> TDCViewDTO {
        var views: [TDCViewDTO] = []
        for _ in 0..<numberOfSubviews {
            views.append(.init(value: .TDCBaseViewDTO(generateBaseViewDTO())))
        }
        return .init(
            value: .TDCBaseViewDTO(
                generateFirstLayerDTO(
                    subviews: views
                )
            )
        )
    }

    private func generateFirstLayerDTO(subviews: [TDCViewDTO]) -> TDCBaseViewDTO {
        return TDCBaseViewDTO(
            id: "base",
            configuration: TDCBaseViewConfigurationDTO(
                color: "#FFFF00",
                cornerRadius: 0,
                onTapAction: nil
            ),
            subviews: subviews,
            constraints: [
                .edge(
                    .init(
                        edge: .topEdge,
                        value: .relative(
                            .init(
                                id: nil, edge: .topEdge, constant: 0
                            )
                        )
                    )
                ),
                .edge(
                    .init(
                        edge: .bottomEdge,
                        value: .relative(
                            .init(
                                id: nil, edge: .bottomEdge, constant: 0
                            )
                        )
                    )
                ),
                .side(
                    .init(
                        side: .leftSide,
                        value: .relative(
                            .init(
                                id: nil, side: .leftSide, constant: 0
                            )
                        )
                    )
                ),
                .side(
                    .init(
                        side: .rightSide,
                        value: .relative(
                            .init(
                                id: nil, side: .rightSide, constant: 0
                            )
                        )
                    )
                ),
            ]
        )
    }
    
    private func generateBaseViewDTO() -> TDCBaseViewDTO {
        let view = TDCBaseViewDTO(
            id: "\(idCounter)",
            configuration: TDCBaseViewConfigurationDTO(
                color: randomColor(),
                cornerRadius: Int.random(in: 0...15),
                onTapAction: nil
            ),
            subviews: [],
            constraints: generateMockConstraitsDTO()
        )
        idCounter += 1
        
        return view
    }
    
    private func generateMockConstraitsDTO() -> [TDCConstraintDTO] {
        return [
            .size(randomHeightConstraint()),
            .size(randomWidthConstraint()),
            .edge(randomEdgeConstraint()),
            .side(randomSideConstraint())
        ]
    }
    
}

extension DTOMockViewGenerator {
    private func randomColor() -> String {
        let array: [String] = ["#FF0000", "#0000FF", "#000000", "#FFA500", "#00FF00"]
        return array.randomElement()!
    }
    private func randomHeightConstraint() -> TDCSizeConstraintDTO {
        return TDCSizeConstraintDTO(
            type: .height,
            value: .absoulte(.init(value: Float.random(in: 50...150)))
        )
    }
    
    private func randomWidthConstraint() -> TDCSizeConstraintDTO {
        return TDCSizeConstraintDTO(
            type: .width,
            value: .absoulte(.init(value: Float.random(in: 50...150)))
        )
    }
    
    private func randomSideConstraint() -> TDCSideConstraintDTO {
        typealias Side = TDCSideConstraintDTO.SideType
        let side: Side = [Side.leftSide, Side.rightSide].randomElement()!
        let constant = Float.random(in: 0...300) * (side == .leftSide ? 1 : -1)
        
        return TDCSideConstraintDTO(
            side: side,
            value: .relative(
                TDCSideConstraintDTO.RelativeConstraintData(
                    id: nil,
                    side: side,
                    constant: constant
                )
            )
        )
    }
    
    private func randomEdgeConstraint() -> TDCEdgeConstraintDTO {
        typealias Edge = TDCEdgeConstraintDTO.EdgeType
        let edge: Edge = [Edge.topEdge, Edge.bottomEdge].randomElement()!
        let constant = Float.random(in: 0...300) * (edge == .topEdge ? 1 : -1)
        
        return TDCEdgeConstraintDTO(
            edge: edge,
            value: .relative(
                TDCEdgeConstraintDTO.RelativeConstraintData(
                    id: nil,
                    edge: edge,
                    constant: constant
                )
            )
        )
    }
    
    
}
