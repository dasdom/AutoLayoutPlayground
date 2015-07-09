//: [Previous](@previous)

import UIKit
import XCPlayground

let hostView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
hostView.backgroundColor = UIColor.yellowColor()
XCPShowView("Host View", view: hostView)

let makeView = { (color: UIColor) -> UIView in
  let view = UIView(frame: CGRect.zeroRect)
  view.translatesAutoresizingMaskIntoConstraints = false
  view.backgroundColor = color
  return view
}

let redView = makeView(UIColor.redColor())
hostView.addSubview(redView)

let blueView = makeView(UIColor.blueColor())
hostView.addSubview(blueView)

if #available(iOS 9, *) {
  var constraints = [NSLayoutConstraint]()
  
  constraints.append(redView.leadingAnchor.constraintEqualToAnchor(hostView.leadingAnchor, constant: 10))
  constraints.append(redView.trailingAnchor.constraintEqualToAnchor(blueView.leadingAnchor, constant: -10))
  constraints.append(redView.topAnchor.constraintEqualToAnchor(hostView.topAnchor, constant: 10))
  constraints.append(redView.bottomAnchor.constraintEqualToAnchor(hostView.bottomAnchor, constant: -10))
  constraints.append(blueView.trailingAnchor.constraintEqualToAnchor(hostView.trailingAnchor, constant: -10))
  constraints.append(blueView.widthAnchor.constraintEqualToConstant(50))
  constraints.append(blueView.heightAnchor.constraintEqualToConstant(20))
  constraints.append(blueView.topAnchor.constraintEqualToAnchor(redView.topAnchor))
  
  NSLayoutConstraint.activateConstraints(constraints)
}

//: [Next](@next)
