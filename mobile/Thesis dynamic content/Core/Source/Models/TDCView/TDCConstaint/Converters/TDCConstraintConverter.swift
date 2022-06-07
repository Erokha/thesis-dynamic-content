import Foundation

struct TDCConstraintDTOToDomainConverter {
    func convert(dto: TDCConstraintDTO) -> TDCConstraint? {
        switch dto {
        case .edge(let edgeDTO):
            return convert(dto: edgeDTO).flatMap { .edge($0) }
        case .side(let sideDTO):
            return convert(dto: sideDTO).flatMap { .side($0) }
        case .size(let sizeDTO):
            return convert(dto: sizeDTO).flatMap { .size($0) }
        case .unknown:
            return nil
        }
        
    }
    
    private func convert(dto: TDCEdgeConstraintDTO) -> TDCEdgeConstraint? {
        guard let edge = TDCConstraintDTOToDomainConverter.convertEdge(from: dto.edge) else {
            return nil
        }
        
        switch dto.value {
        case .relative(let relativeDTO):
            if let relativeData = TDCConstraintDTOToDomainConverter.convertRelativeEdgeData(from: relativeDTO) {
                return TDCEdgeConstraint(edge: edge, value: .relative(relativeData))
            } else {
                return nil
            }
        case .unknown:
            return nil
        }
    }
    
    private func convert(dto: TDCSideConstraintDTO) -> TDCSideConstraint? {
        guard let side = TDCConstraintDTOToDomainConverter.convertSide(from: dto.side) else {
            return nil
        }
        
        switch dto.value {
        case .relative(let relativeDTO):
            if let relativeData = TDCConstraintDTOToDomainConverter.convertRelativeSideData(from: relativeDTO) {
                return TDCSideConstraint(side: side, value: .relative(relativeData))
            } else {
                return nil
            }
        case .unknown:
            return nil
        }
    }
    
    private func convert(dto: TDCSizeConstraintDTO) -> TDCSizeConstraint? {
        guard let sizeType = TDCConstraintDTOToDomainConverter.convertSizeType(from: dto.type) else {
            return nil
        }
        
        switch dto.value {
        case .absoulte(let absoluteDTO):
            return TDCSizeConstraint(
                type: sizeType,
                value: .absoulte(
                    TDCConstraintDTOToDomainConverter.convertAbsoluteSizeData(from: absoluteDTO))
            )
        case .relative(let relativeDTO):
            guard let value = TDCConstraintDTOToDomainConverter.convertRelativeData(from: relativeDTO) else {
                return nil
            }
            return TDCSizeConstraint(
                type: sizeType,
                value: .relative(value)
            )
        case .unknown:
            return nil
        }
    }
}

// MARK: - TDCConstraintDTOToDomainConverter + Edge Helpers

extension TDCConstraintDTOToDomainConverter {
    private static func convertEdge(from dto: TDCEdgeConstraintDTO.EdgeType) -> TDCEdgeConstraint.ConstraintType? {
        switch dto {
        case .topEdge:
            return .topEdge
        case .bottomEdge:
            return .bottomEdge
        case .unknown:
            return nil
        }
    }
    
    private static func convertRelativeEdgeData(from dto: TDCEdgeConstraintDTO.RelativeConstraintData) -> TDCEdgeConstraint.RelativeConstraintData? {
        guard let edge = convertEdge(from: dto.edge) else {
            return nil
        }
        return TDCEdgeConstraint.RelativeConstraintData(
            id: dto.id,
            edge: edge,
            constant: dto.constant
        )
    }
}

// MARK: - TDCConstraintDTOToDomainConverter + Side Helpers

extension TDCConstraintDTOToDomainConverter {
    private static func convertSide(from dto: TDCSideConstraintDTO.SideType) -> TDCSideConstraint.ConstraintType? {
        switch dto {
        case .rightSide:
            return .rightSide
        case .leftSide:
            return .ledftSide
        case .unknown:
            return nil
        }
    }
    
    private static func convertRelativeSideData(from dto: TDCSideConstraintDTO.RelativeConstraintData) -> TDCSideConstraint.RelativeConstraintData? {
        guard let side = convertSide(from: dto.side) else {
            return nil
        }
        return TDCSideConstraint.RelativeConstraintData(
            id: dto.id,
            side: side,
            constant: dto.constant
        )
    }
}

// MARK: - TDCConstraintDTOToDomainConverter + Size Helpers

extension TDCConstraintDTOToDomainConverter {
    private static func convertSizeType(from dto: TDCSizeConstraintDTO.SizeType) -> TDCSizeConstraint.ConstraintType? {
        switch dto {
        case .height:
            return .height
        case .width:
            return .width
        case .unknown:
            return nil
        }
    }
    
    private static func convertAbsoluteSizeData(from dto: TDCSizeConstraintDTO.AbsoluteConstraintData) -> Float {
        return dto.value
    }
    
    private static func convertRelativeData(
        from dto: TDCSizeConstraintDTO.RelativeConstraintData
    ) -> TDCSizeConstraint.RelativeConstraintValue? {
        guard let type = TDCConstraintDTOToDomainConverter.convertSizeType(from: dto.sizeType) else {
            return nil
        }
        if let multiplier = dto.multiplier {
            return TDCSizeConstraint.RelativeConstraintValue(
                id: dto.id,
                type: type,
                value: .multiplier(multiplier)
            )
        } else {
            return TDCSizeConstraint.RelativeConstraintValue(
                id: dto.id,
                type: type,
                value: .constaint(dto.constant ?? 0)
            )
        }
        
    }
}
