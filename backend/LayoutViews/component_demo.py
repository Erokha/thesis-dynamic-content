from constraints.constraints import *
from View.TDCViews import *
from LayoutViews.Components.ColorPicker import ColorPicker


def __make_icon(is_inside_stack=False) -> TDCViewProtocol:
    view = TDCIconView(
        id="demo_main",
        constraints=[
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(100 if is_inside_stack else 200)
            ),
            SizeConstraint(
                size_type=SizeType.width,
                value=AbsoluteSizeValue(200)
            ),
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    id=None,
                    side=Side.left,
                    constant=90
                )
            ),
        ],
        configuration=TDCIconViewConfiguration(
            color=ColorPicker.white.get_color_hex(),
            corner_radius=0,
            on_tap_action=None,
            content_scale_type=TDCIconViewScaleType.scale_to_fill,
            image_url="https://alfakom.uz/images/img/partners/mgtu_baum.jpg"
        ),
        subviews=[]
    )

    if not is_inside_stack:
        view.constraints.append(
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.top,
                    constant=50
                )
            )
        )

    return view


def __make_base() -> TDCViewProtocol:
    return TDCBaseView(
        id="demo_main",
        constraints=[
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(50)
            ),
            SizeConstraint(
                size_type=SizeType.width,
                value=AbsoluteSizeValue(200)
            ),
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    id=None,
                    side=Side.left,
                    constant=90
                )
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
        configuration=TDCBaseViewConfiguration(
            color=ColorPicker.red.get_color_hex(),
            corner_radius=0,
            on_tap_action=None
        ),
        subviews=[]
    )


def __make_text(is_inside_stack=False) -> TDCViewProtocol:
    view = TDCTextView(
        id="demo_main",
        constraints=[
            SizeConstraint(
                size_type=SizeType.width,
                value=AbsoluteSizeValue(200)
            ),
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    id=None,
                    side=Side.left,
                    constant=90
                )
            )
        ],
        configuration=TDCTextViewConfiguration(
            text_color=ColorPicker.black.get_color_hex(),
            text_size=30,
            text="Это текст",
            arrangenment=TDCTextViewArrangenment.center,
            on_tap_action=None
        ),
        subviews=[]
    )

    if not is_inside_stack:
        view.constraints.append(
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(50)
            )
        )
        view.constraints.append(
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.top,
                    constant=50
                )
            )
        )

    return view


def __make_stack() -> TDCViewProtocol:
    return TDCStackView(
        id="stack",
        constraints=[
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    id=None,
                    side=Side.left,
                    constant=20
                )
            ),
            SideConstraint(
                side=Side.right,
                value=RelativeSideValue(
                    id=None,
                    side=Side.right,
                    constant=-20
                )
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.top,
                    constant=20
                )
            ),
            EdgeConstraint(
                edge=Edge.bottom,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.bottom,
                    constant=-20
                )
            )
        ],
        configuration=TDCStackViewConfiguration(
            spacing=20,
            should_show_scroll=True
        ),
        subviews=[
            __make_icon(is_inside_stack=True),
            __make_text(is_inside_stack=True),
        ]
    )



def make_demo_component() -> TDCViewProtocol:
    return __make_stack()
