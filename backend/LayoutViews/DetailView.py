import typing

import TDCActions
from constraints.constraints import *
from View.TDCViews import *
from LayoutViews.Components.ColorPicker import ColorPicker
import LayoutViews.Components.TDCTabbar as tab_bar

list_item_spacing = 20

avatar_id = "avatar"
username_id = "username"
friend_button_id = "friend_button"
stack_view_id = "stack_view"

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

def make_data() -> typing.List[TDCViewProtocol]:
    def make_single_data(key: str, value: str):
        return TDCBaseView(
            id=f"item_{key}_{value}",
            constraints=[
                SideConstraint(
                    side=Side.left,
                    value=RelativeSideValue(
                        side=Side.left,
                        constant=20,
                        id=None
                    )
                ),
                SizeConstraint(
                    size_type=SizeType.height,
                    value=AbsoluteSizeValue(30)
                ),
            ],
            configuration=TDCBaseViewConfiguration(
                color=ColorPicker.white.get_color_hex(),
                corner_radius=0,
                on_tap_action=None
            ),
            subviews=[
                TDCTextView(
                    id=f"item_{key}_text",
                    constraints=[
                        SideConstraint(
                            side=Side.left,
                            value=RelativeSideValue(
                                side=Side.left,
                                constant=0,
                                id=None
                            )
                        ),
                        EdgeConstraint(
                            edge=Edge.top,
                            value=RelativeEdgeValue(
                                edge=Edge.top,
                                constant=5,
                                id=None
                            )
                        ),
                        EdgeConstraint(
                            edge=Edge.bottom,
                            value=RelativeEdgeValue(
                                edge=Edge.bottom,
                                constant=-5,
                                id=None
                            )
                        ),
                        SizeConstraint(
                            size_type=SizeType.width,
                            value=AbsoluteSizeValue(100)
                        ),
                    ],
                    configuration=TDCTextViewConfiguration(
                        text_color=ColorPicker.black.get_color_hex(),
                        text_size=14,
                        text=key,
                        arrangenment=TDCTextViewArrangenment.left,
                        on_tap_action=None
                    ),
                    subviews=[]
                ),
                TDCTextView(
                    id=f"item_{value}_text",
                    constraints=[
                        SideConstraint(
                            side=Side.left,
                            value=RelativeSideValue(
                                side=Side.right,
                                constant=5,
                                id=f"item_{key}_text"
                            )
                        ),
                        SideConstraint(
                            side=Side.right,
                            value=RelativeSideValue(
                                side=Side.right,
                                constant=5,
                                id=None
                            )
                        ),
                        EdgeConstraint(
                            edge=Edge.top,
                            value=RelativeEdgeValue(
                                edge=Edge.top,
                                constant=5,
                                id=None
                            )
                        ),
                        EdgeConstraint(
                            edge=Edge.bottom,
                            value=RelativeEdgeValue(
                                edge=Edge.bottom,
                                constant=-5,
                                id=None
                            )
                        ),
                    ],
                    configuration=TDCTextViewConfiguration(
                        text_color=ColorPicker.black.get_color_hex(),
                        text_size=14,
                        text=value,
                        arrangenment=TDCTextViewArrangenment.left,
                        on_tap_action=None
                    ),
                    subviews=[]
                )
            ]
        )

    return [
        make_single_data("ВУЗ:", "МГТУ им Н.Э.Баумана"),
        make_single_data("Кафедра:", "ИУ7"),
        make_single_data("Место работы:", 'ООО "Майкрософт"'),
        make_single_data("Хобби:", "программирование")
    ]

def make_friend_button(is_friend: bool) -> TDCViewProtocol:
    action = None
    if is_friend:
        action = TDCActions.TDCAlertAction(
            title="Билл уже ваш друг",
            message="",
            options=[
                TDCActions.TDCAlertOption(
                    title="Ок",
                    action=None
                )
            ]
        )
    else :
        action = TDCActions.TDCAlertAction(
            title="Добавить друга?",
            message="Хотите добавить Билла Гейтса в друзья?",
            options=[
                TDCActions.TDCAlertOption(
                    title="Да",
                    action=TDCActions.TDCTransitAction(new_url="http:/localhost:5000/profile_view?is_friend=true")
                ),
                TDCActions.TDCAlertOption(
                    title="Нет",
                    action=None
                )
            ]
        )
    text = TDCTextView(
        id=friend_button_id + "_text",
        constraints=[
            SideConstraint(
                side=Side.left,
                value=RelativeSideValue(
                    side=Side.left,
                    constant=5,
                    id=None
                )
            ),
            SideConstraint(
                side=Side.right,
                value=RelativeSideValue(
                    side=Side.right,
                    constant=5,
                    id=None
                )
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    edge=Edge.top,
                    constant=5,
                    id=None
                )
            ),
            EdgeConstraint(
                edge=Edge.bottom,
                value=RelativeEdgeValue(
                    edge=Edge.bottom,
                    constant=5,
                    id=None
                )
            ),
        ],
        configuration=TDCTextViewConfiguration(
            text_color=ColorPicker.white.value,
            text_size=14,
            text= "Ваш друг" if is_friend else "Добавить в друзья",
            arrangenment=TDCTextViewArrangenment.center,
            on_tap_action=None
        ),
        subviews=[]
    )
    return TDCBaseView(
        id=friend_button_id,
        constraints=[
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(30)
            ),
            SizeConstraint(
                size_type=SizeType.width,
                value=AbsoluteSizeValue(170)
            ),
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    id=avatar_id,
                    edge=Edge.bottom,
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
        ],
        configuration=TDCBaseViewConfiguration(
            color=ColorPicker.sky_blue.get_color_hex(),
            corner_radius=10,
            on_tap_action=action
        ),
        subviews=[
            text
        ]
    )

def make_stack_view(items: [TDCViewProtocol]) -> TDCViewProtocol:
    return TDCStackView(
        id=stack_view_id,
        constraints=[
            EdgeConstraint(
                edge=Edge.top,
                value=RelativeEdgeValue(
                    edge=Edge.bottom,
                    constant=20,
                    id=friend_button_id
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
        configuration=TDCStackViewConfiguration(spacing=10, should_show_scroll=False),
        subviews=items
    )
    return stack_view


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
            text="Билл Гейтс",
            arrangenment=TDCTextViewArrangenment.left,
            on_tap_action=None
        ),
        subviews=[]
    )



def make_detail_view(is_friend: bool):
    view = make_background_view()
    bar = tab_bar.TDCTabBar()
    items = make_data()
    view.subviews = [
        make_avatar(),
        make_username(),
        make_friend_button(is_friend),
        make_stack_view(items),
        bar.make_tab_bar(page=bar.Page.profile_page)
    ]
    return view
