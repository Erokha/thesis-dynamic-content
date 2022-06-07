from constraints.constraints import *
from View.TDCViews import *
from LayoutViews.Components.ColorPicker import ColorPicker

def make_base_view():
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
            color=ColorPicker.mint.get_color_hex(),
            corner_radius=0,
            on_tap_action=None
        ),
        subviews=[]
    )

def make_text_view():
    return TDCTextView(
        id="text_view",
        constraints=[
            SideConstraint(
                side=Side.right,
                value=RelativeSideValue(
                    id=None,
                    side=Side.right,
                    constant=-20
                )
            ),
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    id=None,
                    side=Side.left,
                    constant=20
                )
            ),
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(50)
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.top,
                    constant=50
                )
            )
        ],
        configuration=TDCTextViewConfiguration(
            text_color=ColorPicker.black.get_color_hex(),
            text_size=14,
            text="Текстовый элемент",
            arrangenment=TDCTextViewArrangenment.center,
            on_tap_action=None
        ),
        subviews=[]
    )

def make_round_view():
    return TDCBaseView(
        id="circle_view",
        constraints=[
            SizeConstraint(
                size_type= SizeType.height,
                value=AbsoluteSizeValue(50)
            ),
            SizeConstraint(
                size_type=SizeType.width,
                value=AbsoluteSizeValue(50)
            ),
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    id=None,
                    side=Side.left,
                    constant=120
                )
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id="text_view",
                    edge=Edge.top,
                    constant=50
                )
            )
        ],
        configuration=TDCBaseViewConfiguration(
            color=ColorPicker.red.get_color_hex(),
            corner_radius=25,
            on_tap_action=None
        ),
        subviews=[]
    )