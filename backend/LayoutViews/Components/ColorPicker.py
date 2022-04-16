from enum import Enum


class ColorPicker(Enum):
    white = "#FFFFFF"
    gray = "#808080"
    light_gray = "#AFAFAF"
    red = "#FF0000"
    navy = "#000080"
    orange = "#FFA500"
    mint = "#99FFCC"
    yellow = "##FFFF00"
    black = "#000000"

    def get_color_hex(self) -> str:
        return self.value
