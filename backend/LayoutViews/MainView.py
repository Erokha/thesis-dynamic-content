from constraints.constraints import *
from View.TDCViews import *
from LayoutViews.Components.ColorPicker import ColorPicker
import LayoutViews.Components.TDCListItem as li
import TDCActions as action

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

def make_header_view():
    textView = TDCTextView(
        id="main_header_text",
        constraints=[
            EdgeConstraint(
                edge=Edge.bottom,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.bottom,
                    constant=-40
                )
            ),
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(
                    value=35
                )
            ),
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    id=None,
                    side=Side.left,
                    constant=40
                )
            ),
            SideConstraint(
                side=Side.right,
                value=RelativeSideValue(
                    id=None,
                    side=Side.right,
                    constant=-40
                )
            )
        ],
        configuration=TDCTextViewConfiguration(
            text_color="#ffffff",
            text_size=32,
            text="Owzeego",
            arrangenment=TDCTextViewArrangenment.center,
            on_tap_action=None
        ),
        subviews=[]
    )
    subtitleView = TDCTextView(
        id="main_header_subtitle",
        constraints=[
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id="main_header_text",
                    edge=Edge.bottom,
                    constant=10
                )
            ),
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(
                    value=20
                )
            ),
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    id=None,
                    side=Side.left,
                    constant=40
                )
            ),
            SideConstraint(
                side=Side.right,
                value=RelativeSideValue(
                    id=None,
                    side=Side.right,
                    constant=-40
                )
            )
        ],
        configuration=TDCTextViewConfiguration(
            text_color="#ffffff",
            text_size=10,
            text="stan smith",
            arrangenment=TDCTextViewArrangenment.center,
            on_tap_action=None
        ),
        subviews=[]
    )
    return TDCBaseView(
        id="main_header",
        constraints=[
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.top,
                    constant=-60
                )
            ),
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(
                    value=160
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
            color=ColorPicker.navy.get_color_hex(),
            corner_radius=20,
            on_tap_action=None
        ),
        subviews=[
            textView,
            subtitleView
        ]
    )

def make_list_item(number: int):
    list_item = li.TDCListItem(
        id=f"list_item_{number}",
        image_url="https://commons.bmstu.wiki/images/c/c4/IU7-im.png",
        title=f"List Item #{number}",
        background_color=ColorPicker.orange.get_color_hex(),
        title_color=ColorPicker.red.get_color_hex(),
    ).to_base_view()
    add_constraints = [
        SideConstraint(
            side=Side.left,
            value=RelativeSideValue(
                side=Side.left,
                constant=20,
                id=None
            )
        ),
        SideConstraint(
            side=Side.right,
            value=RelativeSideValue(
                side=Side.right,
                constant=-20,
                id=None
            )
        ),
        EdgeConstraint(
            edge=Edge.top,
            value=RelativeEdgeValue(
                edge=Edge.bottom,
                constant=35 if number == 1 else 20,
                id= "main_header" if number == 1 else f"list_item_{number - 1}",
            )
        )
    ]
    for constraint in add_constraints:
        list_item.constraints.append(constraint)
    list_item.configuration.on_tap_action = action.TDCAlertAction(
        title=f"Alert title of list_item number {number}",
        message="AlertMessage",
        options=[
            action.TDCAlertOption(
                title="First option",
                action=None,
            ),
            action.TDCAlertOption(
                title="Second option",
                action=None,
            ),
            action.TDCAlertOption(
                title="Third option",
                action=None,
            )
        ]
    )
    return list_item


def make_tab_bar():
    left_tabbar_item = TDCBaseView(
        id=f"tab_bar_item_left",
        constraints=[
            EdgeConstraint(
                edge=Edge.bottom,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.bottom,
                    constant=-10
                )
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.top,
                    constant=10
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
                size_type=SizeType.width,
                value=AbsoluteSizeValue(
                    value=25
                )
            )
        ],
        configuration=TDCBaseViewConfiguration(
            color=ColorPicker.navy.get_color_hex(),
            corner_radius=0,
            on_tap_action=None
        ),
        subviews=[]
    )
    middle_tabbar_item = TDCBaseView(
        id=f"tab_bar_item_middle",
        constraints=[
            EdgeConstraint(
                edge=Edge.bottom,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.bottom,
                    constant=-10
                )
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.top,
                    constant=10
                )
            ),
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    id=None,
                    side=Side.left,
                    constant=145
                )
            ),
            SizeConstraint(
                size_type=SizeType.width,
                value=AbsoluteSizeValue(
                    value=25
                )
            )
        ],
        configuration=TDCBaseViewConfiguration(
            color=ColorPicker.navy.get_color_hex(),
            corner_radius=0,
            on_tap_action=None
        ),
        subviews=[]
    )
    right_tabbar_item = TDCBaseView(
        id=f"tab_bar_item_right",
        constraints=[
            EdgeConstraint(
                edge=Edge.bottom,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.bottom,
                    constant=-10
                )
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.top,
                    constant=10
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
            SizeConstraint(
                size_type=SizeType.width,
                value=AbsoluteSizeValue(
                    value=25
                )
            )
        ],
        configuration=TDCBaseViewConfiguration(
            color=ColorPicker.navy.get_color_hex(),
            corner_radius=0,
            on_tap_action=None
        ),
        subviews=[]
    )
    return TDCBaseView(
        id=f"tab_bar",
        constraints=[
            EdgeConstraint(
                edge=Edge.bottom,
                value=RelativeEdgeValue(
                    id=None,
                    edge=Edge.bottom,
                    constant=0
                )
            ),
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(
                    value=45
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
            color="#B4B4B4",
            corner_radius=0,
            on_tap_action=None
        ),
        subviews=[
            left_tabbar_item,
            middle_tabbar_item,
            right_tabbar_item
        ]
    )

def make_main_view():
    view = make_background_view()
    view.subviews = [
        make_header_view(),
        make_list_item(1),
        make_list_item(2),
        make_list_item(3),
        make_list_item(4),
        make_list_item(5),
        make_tab_bar()
    ]
    return view
