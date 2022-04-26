from constraints.constraints import *
from View.TDCViews import *
from LayoutViews.Components.ColorPicker import ColorPicker

list_item_spacing = 20

def make_background_view():
    return TDCBaseView(
        id="main_header",
        constraints=[
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.top,
                    constant=0
                )
            ),
            EdgeConstraint(
                edge=Edge.bottom,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.bottom,
                    constant=0
                )
            ),
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    id=None,
                    side=Side.left,
                    constant=0
                )
            ),
            SideConstraint(
                side=Side.right,
                value=RelativeSideValue(
                    id=None,
                    side=Side.right,
                    constant=0
                )
            )
        ],
        configuration=TDCBaseViewConfiguration(
            color="#FFFFFF",
            corner_radius=0,
            on_tap_action=None
        ),
        subviews=[]
    )

def make_avatar():
    return TDCIconView(
        id="avatar",
        constraints=[
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    side=Side.left,
                    constant=70,
                    id=None
                )
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    edge=Edge.top,
                    constant=70,
                    id=None
                )
            ),
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(
                    value=50
                )
            ),
            SizeConstraint(
                size_type=SizeType.width,
                value=RelativeSizeValue(
                    id="avatar",
                    size_type=SizeType.height,
                    constraintType=RelativeSizeConstraint.multiplier,
                    value=1
                )
            ),
        ],
        configuration=TDCIconViewConfiguration(
            color=ColorPicker.white.value,
            corner_radius=25,
            content_scale_type=TDCIconViewScaleType.scale_aspect_fill,
            image_url="https://avatars.mds.yandex.net/get-kino-vod-films-gallery/28788/47e2fd514411e18b76af786d7417062d/100x64_3",
            on_tap_action=None
        ),
        subviews=[]
    )

def make_detail_view():
    view = make_background_view()
    view.subviews = [
        make_avatar()
    ]
    return view
