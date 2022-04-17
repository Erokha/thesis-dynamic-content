import constraints.constraints as constraints
import View.TDCViews as tdc
from LayoutViews.Components.ColorPicker import ColorPicker
import typing

TDCLISTITEMHEIGHT = 45

class TDCListItem:
    id: str
    image_url: typing.Optional[str]
    title: typing.Optional[str]
    background_color: str
    title_color: str


    def __init__(
            self,
            id: str,
            image_url: typing.Optional[str] = None,
            title: typing.Optional[str] = None,
            background_color: typing.Optional[str] = None,
            title_color: typing.Optional[str] = None,
    ):
        self.id = id
        self.image_url = image_url
        self.title = title
        self.background_color = background_color if background_color else ColorPicker.white.get_color_hex()
        self.title_color = title_color if title_color else ColorPicker.black.get_color_hex()

    def image_view_id(self) -> typing.Optional[str]:
        return f"list_item_id_{self.id}_icon" if self.image_url else None

    def title_id(self) -> typing.Optional[str]:
        return f"list_item_id_{self.id}_title" if self.title else None

    def __make_title(self) -> typing.Optional[tdc.TDCTextView]:
        if self.title_id() is None:
            return None

        return tdc.TDCTextView(
            id=self.title_id(),
            constraints=[
                constraints.EdgeConstraint(
                    edge=constraints.Edge.top,
                    value=constraints.RelativeEdgeValue(
                        edge=constraints.Edge.top,
                        constant=5,
                        id=None
                    )
                ),
                constraints.EdgeConstraint(
                    edge=constraints.Edge.bottom,
                    value=constraints.RelativeEdgeValue(
                        edge=constraints.Edge.bottom,
                        constant=-10,
                        id=None
                    )
                ),
                constraints.SideConstraint(
                    side=constraints.Side.right,
                    value=constraints.RelativeSideValue(
                        side=constraints.Side.right,
                        constant=-10,
                        id=None
                    )
                ),
                constraints.SideConstraint(
                    side=constraints.Side.left,
                    value=constraints.RelativeSideValue(
                        side=constraints.Side.right if self.image_view_id() else constraints.Side.left,
                        constant=30,
                        id=self.image_view_id()
                    )
                )
            ],
            configuration=tdc.TDCTextViewConfiguration(
                text_color=self.title_color,
                text_size=14,
                text="Test text",
                arrangenment=None,
                on_tap_action=None
            ),
            subviews=[]
        )

    def __make_image(self) -> typing.Optional[tdc.TDCIconView]:
        if self.image_view_id() is None:
            return None

        return tdc.TDCIconView(
            id=self.image_view_id(),
            constraints=[
                constraints.EdgeConstraint(
                    edge=constraints.Edge.top,
                    value=constraints.RelativeEdgeValue(
                        id=None,
                        edge=constraints.Edge.top,
                        constant=10
                    )
                ),
                constraints.EdgeConstraint(
                    edge=constraints.Edge.bottom,
                    value=constraints.RelativeEdgeValue(
                        id=None,
                        edge=constraints.Edge.bottom,
                        constant=-10
                    )
                ),
                constraints.SizeConstraint(
                    size_type=constraints.SizeType.width,
                    value=constraints.AbsoluteSizeValue(
                        # TODO: fix to relative, that equals self height
                        value=30
                    )
                ),
                constraints.SideConstraint(
                    side=constraints.Side.left,
                    value=constraints.RelativeSideValue(
                        id=None,
                        side=constraints.Side.left,
                        constant=10
                    )
                )
            ],
            configuration=tdc.TDCIconViewConfiguration(
                color=self.background_color,
                corner_radius=5,
                content_scale_type=tdc.TDCIconViewScaleType.scale_aspect_fill,
                image_url=self.image_url,
                on_tap_action=None
            ),
            subviews=[]
        )

    def to_base_view(self) -> tdc.TDCBaseView:
        base_view =  tdc.TDCBaseView(
            id=self.id,
            constraints=[
                constraints.SizeConstraint(
                    size_type=constraints.SizeType.height,
                    value=constraints.AbsoluteSizeValue(
                        value=TDCLISTITEMHEIGHT
                    )
                )
            ],
            subviews=[],
            configuration=tdc.TDCBaseViewConfiguration(
                color=self.background_color,
                corner_radius=10,
                on_tap_action=None
            )
        )

        if self.__make_title():
            base_view.subviews.append(self.__make_title())
        if self.__make_image():
            base_view.subviews.append(self.__make_image())

        return base_view
