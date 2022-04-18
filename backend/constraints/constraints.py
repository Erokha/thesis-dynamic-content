import abc
import typing
from dataclasses import dataclass
from typing import Optional
from enum import Enum


class Constraint:
    @abc.abstractmethod
    def serialize(self) -> dict:
        pass


"""
MARK: - Edge constraints
"""


class Edge(Enum):
    top = "top"
    bottom = "bottom"


@dataclass
class RelativeEdgeValue:
    edge: Edge
    constant: int
    id: Optional[str]

    def to_dict(self):
        data = {
            "type": "relative",
            "edge": self.edge.value,
            "constant": self.constant
        }
        if self.id and self.id != "":
            data["id"] = self.id

        return data


@dataclass
class EdgeConstraint(Constraint):
    edge: Edge
    value: RelativeEdgeValue

    def serialize(self) -> dict:
        return {
            "type": "edge",
            "edge": self.edge.value,
            "value": self.value.to_dict()
        }


"""
MARK: - Side constraints
"""


class Side(Enum):
    left = "left"
    right = "right"


@dataclass
class RelativeSideValue:
    side: Side
    constant: int
    id: Optional[str]

    def to_dict(self):
        data = {
            "type": "relative",
            "side": self.side.value,
            "constant": self.constant
        }
        if self.id and self.id != "":
            data["id"] = self.id

        return data


@dataclass
class SideConstraint(Constraint):
    side: Side
    value: RelativeSideValue

    def serialize(self) -> dict:
        return {
            "type": "side",
            "side": self.side.value,
            "value": self.value.to_dict()
        }


"""
MARK: - Size constraints
"""


class SizeType(Enum):
    height = "height"
    width = "width"

class RelativeSizeConstraint(Enum):
    constant = "constant"
    multiplier = "multiplier"

class SizeConstraintValue:
    @abc.abstractmethod
    def serialize(self) -> dict:
        pass

@dataclass
class AbsoluteSizeValue(SizeConstraintValue):
    value: int

    def serialize(self) -> dict:
        return {
            "type": "absolute",
            "value": self.value,
        }

@dataclass
class RelativeSizeValue(SizeConstraintValue):
    id: typing.Optional[str]
    size_type: SizeType
    constraintType: RelativeSizeConstraint
    value: float

    def serialize(self) -> dict:
        data = {
            "type": "relative",
            "size_type": self.size_type.value,
        }
        if self.id:
            data["id"] = self.id
        if self.constraintType == RelativeSizeConstraint.constant:
            data["constant"] = int(self.value)
        elif self.constraintType == RelativeSizeConstraint.multiplier:
            data["multiplier"] = self.value
        return data


@dataclass
class SizeConstraint(Constraint):
    size_type: SizeType
    value: SizeConstraintValue

    def serialize(self) -> dict:
        return {
            "type": "size",
            "size_type": self.size_type.value,
            "value": self.value.serialize()
        }
