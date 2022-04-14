from constraints.constraints import *
from View.TDCViews import *


def make_test_text_view():
    return TDCTextView(
        id="test_text_view",
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
                    constant=100
                )
            ),
            SizeConstraint(
                size_type=SizeType.height,
                value=AbsoluteSizeValue(
                    value=50
                )
            )
        ],
        configuration=TDCTextViewConfiguration(
            text_color="#ffffff",
            text_size=16,
            text="Fuck you",
            arrangenment=TDCTextViewArrangenment.right
        ),
        subviews=[]
    )