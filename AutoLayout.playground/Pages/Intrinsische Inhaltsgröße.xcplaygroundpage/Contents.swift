//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

/*:
# Auto Layout Core Concepts

## Intrinsic Content Size

1. Method of UIView

*/

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = UIColor.redColor()
XCPShowView("view", view: view)

let subview = UIView(frame: .zero)
subview.translatesAutoresizingMaskIntoConstraints = false
subview.backgroundColor = UIColor.yellowColor()
subview.clipsToBounds = true
view.addSubview(subview)

/*:
2. Default implementation return kind of an empty size
*/

subview.intrinsicContentSize()

let zeroSize = CGSize.zero

let label = UILabel(frame: .zero)
label.translatesAutoresizingMaskIntoConstraints = false
label.text = "Auto Layout"

label.intrinsicContentSize()

label.font = UIFont.systemFontOfSize(30)

label.intrinsicContentSize()
subview.addSubview(label)
subview.intrinsicContentSize()

let views = ["label": label, "subView": subview]
var constraints = [NSLayoutConstraint]()
constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-[label]", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[label]", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-[subView]", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[subView]", options: [], metrics: nil, views: views)

NSLayoutConstraint.activateConstraints(constraints)

view

view.removeConstraints(constraints)
constraints.removeAll()

constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-[label]-|", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[label]-|", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-[subView]", options: [], metrics: nil, views: views)
constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-[subView]", options: [], metrics: nil, views: views)

NSLayoutConstraint.activateConstraints(constraints)

view

subview.intrinsicContentSize()
