from constraints.constraints import *
from View.TDCViews import *
from LayoutViews.Components.ColorPicker import ColorPicker
import LayoutViews.Components.TDCListItem as li
import TDCActions as action
import LayoutViews.Components.TDCTabbar as tab_bar


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
                    value=140
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
            color="#008000",
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

def make_stack_view():
    items = [
        make_list_item(1),
        make_list_item(2),
        make_list_item(3),
        make_list_item(4),
        make_list_item(5),
        make_list_item(6),
        make_list_item(7),
        make_list_item(8),
    ]
    stack_view = TDCStackView(
        id="stack_view",
        constraints=[
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    edge=Edge.bottom,
                    constant=50,
                    id="main_header"
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
            ),
            EdgeConstraint(
                edge=Edge.bottom,
                value=RelativeEdgeValue(
                    edge=Edge.top,
                    constant=-10,
                    id="tab_bar"
                )
            )
        ],
        configuration=TDCStackViewConfiguration(spacing=10, direction=TDCStackViewDirection.vertical),
        subviews=items
    )
    return stack_view

def make_main_view():
    view = make_background_view()
    bar = tab_bar.TDCTabBar()
    view.subviews = [
        make_header_view(),
        make_stack_view(),
        bar.make_tab_bar(page=bar.Page.main_page)
    ]
    return view
