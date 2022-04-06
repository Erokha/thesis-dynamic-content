//
//  TDCConstraintConverter.swift
//  Thesis dynamic content
//
//  Created by erokha on 4/6/22.
//

import Foundation

struct TDCConstraintDTOToDomainConverter {
    func convert(dto: TDCEdgeConstaintDTO) -> TDCEdgeConstaint? {
        guard let edge = TDCConstraintDTOToDomainConverter.convertEdge(from: dto.edge) else {
            return nil
        }
        
        switch dto.value {
        case .relative(let relativeData):
            if let relative = TDCConstraintDTOToDomainConverter.convertRelativeData(from: relativeData) {
                return TDCEdgeConstaint(edge: edge, value: .relative(relative))
            } else {
                return nil
            }
        case .unknown:
            return nil
        }
    }
}

extension TDCConstraintDTOToDomainConverter {
    private static func convertEdge(from dto: TDCEdgeConstaintDTO.EdgeType) -> TDCEdgeConstaint.ConstaintType? {
        switch dto {
        case .topEdge:
            return .topEdge
        case .bottomEdge:
            return .bottomEdge
        case .unknown:
            return nil
        }
    }
    
    private static func convertRelativeData(from dto: TDCEdgeConstaintDTO.RelativeConstaintData) -> TDCEdgeConstaint.RelativeConstaintData? {
        guard let edge = convertEdge(from: dto.edge) else {
            return nil
        }
        return TDCEdgeConstaint.RelativeConstaintData(
            id: dto.id,
            edge: edge,
            constant: dto.constant
        )
    }
}
