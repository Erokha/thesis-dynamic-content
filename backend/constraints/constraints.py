import abc
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


@dataclass
class AbsoluteSizeValue:
    value: int

    def to_dict(self):
        return {
            "type": "absolute",
            "value": self.value,
        }


@dataclass
class SizeConstraint(Constraint):
    size_type: SizeType
    value: AbsoluteSizeValue

    def serialize(self) -> dict:
        return {
            "type": "size",
            "size_type": self.size_type.value,
            "value": self.value.to_dict()
        }
