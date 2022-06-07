from constraints import constraints as c
from dataclasses import dataclass
from TDCActions import TDCAction
import typing
import abc
from enum import Enum

"""
MARK: - ViewProtocol
"""


class TDCViewProtocol:
    @abc.abstractmethod
    def serialize(self) -> dict:
        pass


"""
======================================
MARK: - BaseView
======================================
"""


@dataclass
class TDCBaseViewConfiguration:
    color: typing.Optional[str]
    corner_radius: typing.Optional[int]
    on_tap_action: typing.Optional[TDCAction]

    def serialize(self) -> dict:
        data = {}
        if self.color:
            data["color"] = self.color
        if self.corner_radius:
            data["corner_radius"] = self.corner_radius
        if self.on_tap_action:
            data["on_tap_action"] = self.on_tap_action.serialize()
        return data


@dataclass
class TDCBaseView(TDCViewProtocol):
    id: str
    constraints: typing.List[c.Constraint]
    configuration: TDCBaseViewConfiguration
    subviews: typing.List[TDCViewProtocol]

    def serialize(self) -> dict:
        return {
            "type": "base_view",
            "id": self.id,
            "configuration": self.configuration.serialize(),
            "subviews": [subview.serialize() for subview in self.subviews],
            "constraints": [constraint.serialize() for constraint in self.constraints]
        }


"""
======================================
MARK: - TextView
======================================
"""


class TDCTextViewArrangenment(Enum):
    left = "left"
    right = "right"
    center = "center"


@dataclass
class TDCTextViewConfiguration:
    text_color: typing.Optional[str]
    text_size: typing.Optional[int]
    text: str
    arrangenment: typing.Optional[TDCTextViewArrangenment]
    on_tap_action: typing.Optional[TDCAction]

    def serialize(self) -> dict:
        data = {
            "text": self.text
        }
        if self.text_color:
            data["text_color"] = self.text_color
        if self.text_size:
            data["text_size"] = self.text_size
        if self.arrangenment:
            data["arrangenment"] = self.arrangenment.value
        if self.on_tap_action:
            data["on_tap_action"] - self.on_tap_action.serialize()
        return data


@dataclass
class TDCTextView(TDCViewProtocol):
    id: str
    constraints: typing.List[c.Constraint]
    configuration: TDCTextViewConfiguration
    subviews: typing.List[TDCViewProtocol]

    def serialize(self) -> dict:
        return {
            "type": "text_view",
            "id": self.id,
            "configuration": self.configuration.serialize(),
            "subviews": [subview.serialize() for subview in self.subviews],
            "constraints": [constraint.serialize() for constraint in self.constraints]
        }


"""
======================================
MARK: - IconView
======================================
"""


class TDCIconViewScaleType(Enum):
    scale_aspect_fill = "scale_aspect_fill"
    scale_to_fill = "scale_to_fill"
    normal = "normal"


@dataclass
class TDCIconViewConfiguration:
    color: typing.Optional[str]
    corner_radius: typing.Optional[int]
    content_scale_type: typing.Optional[TDCIconViewScaleType]
    image_url: str
    on_tap_action: typing.Optional[TDCAction]

    def serialize(self) -> dict:
        data = {
            "image_url": self.image_url
        }
        if self.color:
            data["color"] = self.color
        if self.corner_radius:
            data["corner_radius"] = self.corner_radius
        if self.content_scale_type:
            data["content_scale_type"] = self.content_scale_type.value
        if self.on_tap_action:
            data["on_tap_action"] - self.on_tap_action.serialize()
        return data


@dataclass
class TDCIconView(TDCViewProtocol):
    id: str
    constraints: typing.List[c.Constraint]
    configuration: TDCIconViewConfiguration
    subviews: typing.List[TDCViewProtocol]

    def serialize(self) -> dict:
        return {
            "type": "icon_view",
            "id": self.id,
            "configuration": self.configuration.serialize(),
            "subviews": [subview.serialize() for subview in self.subviews],
            "constraints": [constraint.serialize() for constraint in self.constraints]
        }


"""
======================================
MARK: - Stack View
======================================
"""


class TDCStackViewDirection(Enum):
    vertical = "vertical"
    horizontal = "horizontal"


@dataclass
class TDCStackViewConfiguration:
    spacing: typing.Optional[int]
    should_show_scroll: typing.Optional[bool]

    def serialize(self) -> dict:
        data = {}
        if self.spacing:
            data["spacing"] = self.spacing
        if self.should_show_scroll is not None:
            data["should_show_scroll"] = self.should_show_scroll
        return data


@dataclass
class TDCStackView(TDCViewProtocol):
    id: str
    constraints: typing.List[c.Constraint]
    configuration: TDCStackViewConfiguration
    subviews: typing.List[TDCViewProtocol]

    def serialize(self) -> dict:
        return {
            "type": "stack_view",
            "id": self.id,
            "configuration": self.configuration.serialize(),
            "subviews": [subview.serialize() for subview in self.subviews],
            "constraints": [constraint.serialize() for constraint in self.constraints]
        }
