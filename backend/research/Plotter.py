import dataclasses
import matplotlib.pyplot as plt
import typing

@dataclasses.dataclass
class PlotInfo:
    x: typing.List
    y: typing.List
    title: str

class Plotter:

    data_arrays: typing.List[PlotInfo]
    title: str
    x_label: str
    y_label: str



    def __init__(
            self,
            data_arrays: typing.List[PlotInfo],
            title: str = "",
            x_label: str = "",
            y_label: str = ""
    ):
        self.data_arrays = data_arrays
        self.title = title
        self.x_label = x_label
        self.y_label = y_label

    def draw(self, should_save_to_pdf: bool):
        for element in self.data_arrays:
            plt.plot(element.x, element.y, label=element.title)

        plt.xlabel(self.x_label)
        plt.ylabel(self.y_label)

        plt.title(self.title)

        if len(self.data_arrays) > 1:
            plt.legend()

        if should_save_to_pdf:
            plt.savefig("foo.pdf", format="pdf", bbox_inches="tight")

        plt.show()
