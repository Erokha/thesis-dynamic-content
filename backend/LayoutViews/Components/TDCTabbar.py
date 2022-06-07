from constraints.constraints import *
from View.TDCViews import *
from LayoutViews.Components.ColorPicker import ColorPicker
import TDCActions as action
from enum import Enum


class TDCTabBar:
    class Page(Enum):
        main_page = "main"
        profile_page = "profile"
        middle_page = "middle"

    __main_item_id = Page.main_page.value + "_item"
    __middle_item_id = Page.middle_page.value + "_item"
    __profile_item_id = Page.profile_page.value + "_item"

    def __make_main_tab_bar_item(self, page: Page):
        return TDCBaseView(
            id=self.__main_item_id,
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
                color=ColorPicker.navy.get_color_hex() if page == self.Page.main_page else ColorPicker.mint.get_color_hex(),
                corner_radius=0,
                on_tap_action=None if page == self.Page.main_page else action.TDCTransitAction(
                    new_url="http:/localhost:5000/main_view"
                )
            ),
            subviews=[]
        )

    def __make_middle_tab_bar_item(self, page: Page):
        return TDCBaseView(
            id=self.__middle_item_id,
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
                color=ColorPicker.navy.get_color_hex() if page == self.Page.middle_page else ColorPicker.mint.get_color_hex(),
                corner_radius=0,
                on_tap_action=action.TDCAlertAction(
                    title="Предупреждение",
                    message="Тут пока нет страницы",
                    options=[
                        action.TDCAlertOption(
                            title="Ок"
                        )
                    ]
                )
            ),
            subviews=[]
        )

    def __make_profile_tab_bar_item(self, page: Page):
        return TDCBaseView(
            id=self.__profile_item_id,
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
                color=ColorPicker.navy.get_color_hex() if page == self.Page.profile_page else ColorPicker.mint.get_color_hex(),
                corner_radius=0,
                on_tap_action=None if page == self.Page.profile_page else action.TDCTransitAction(
                    new_url="http://127.0.0.1:5000/profile_view"
                )
            ),
            subviews=[]
        )

    def make_tab_bar(self, page: Page):
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
                self.__make_main_tab_bar_item(page=page),
                self.__make_middle_tab_bar_item(page=page),
                self.__make_profile_tab_bar_item(page=page),
            ]
        )
