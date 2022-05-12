from constraints.constraints import *
from View.TDCViews import *
from LayoutViews.Components.ColorPicker import ColorPicker
import LayoutViews.Components.TDCTabbar as tab_bar

list_item_spacing = 20

avatar_id = "avatar"
username_id = "username"

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
        id=avatar_id,
        constraints=[
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    side=Side.left,
                    constant=20,
                    id=None
                )
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    edge=Edge.top,
                    constant=30,
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
            image_url="https://upload.wikimedia.org/wikipedia/commons/c/c1/Visit_of_Bill_Gates%2C_Chairman_of_Breakthrough_Energy_Ventures%2C_to_the_European_Commission_5_%28cropped%29.jpg",
            on_tap_action=None
        ),
        subviews=[]
    )

def make_username():
    return TDCTextView(
        id=username_id,
        constraints=[
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    side=Side.right,
                    constant=10,
                    id=avatar_id
                )
            ),
            SideConstraint(
                side=Side.right,
                value=RelativeSideValue(
                    side=Side.right,
                    constant=10,
                    id=None
                )
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    edge=Edge.top,
                    constant=0,
                    id=avatar_id
                )
            ),
            EdgeConstraint(
                edge=Edge.bottom,
                value=RelativeEdgeValue(
                    edge=Edge.bottom,
                    constant=0,
                    id=avatar_id
                )
            ),
        ],
        configuration=TDCTextViewConfiguration(
            text_color=ColorPicker.black.value,
            text_size=14,
            text="IU7 Student",
            arrangenment=TDCTextViewArrangenment.left,
            on_tap_action=None
        ),
        subviews=[]
    )



def make_detail_view():
    view = make_background_view()
    bar = tab_bar.TDCTabBar()
    view.subviews = [
        make_avatar(),
        make_username(),
        bar.make_tab_bar(page=bar.Page.profile_page)
    ]
    return view
