import typing
import abc
from dataclasses import dataclass


class TDCAction:
    @abc.abstractmethod
    def serialize(self) -> dict:
        pass


"""
MARK: - Alert
"""


@dataclass
class TDCAlertOption:
    title: str
    action: typing.Optional[TDCAction]

    def __init__(
            self,
            title: str,
            action: typing.Optional[TDCAction] = None):
        self.title = title
        self.action = action

    def serialize(self) -> dict:
        data = {"title": self.title}
        if self.action:
            data["action"] = self.action.serialize()
        return data


@dataclass
class TDCAlertAction(TDCAction):
    title: str
    message: str
    options: typing.List[TDCAlertOption]

    def serialize(self):
        return {
            "type": "alert",
            "title": self.title,
            "message": self.message,
            "options": [option.serialize() for option in self.options]
        }

"""
MARK: - Alert
"""

@dataclass
class TDCTransitAction(TDCAction):
    new_url: str

    def serialize(self):
        return {
            "type": "transit",
            "new_url": self.new_url
        }
