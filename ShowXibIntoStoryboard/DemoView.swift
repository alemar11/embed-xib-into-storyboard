//
//  TestView.swift
//  ShowXibIntoStoryboard
//
//  Created by Alessandro Marzoli on 29/05/2019.
//  Copyright © 2019 Alessandro Marzoli. All rights reserved.
//

import UIKit

@IBDesignable
class DemoView: UIView {
  
  @IBOutlet weak var label: UILabel!

  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    if !subviews.isEmpty {
      return self
    }

    // load the real view

    let bundle = Bundle(for: type(of: self))
    if let loadedView = bundle.loadNibNamed("DemoView", owner: nil, options: nil)?.first as? UIView {
      // not relevant for this particular example
      //loadedView.frame = frame
      //loadedView.autoresizingMask = autoresizingMask
      loadedView.clipsToBounds = clipsToBounds
      loadedView.alpha = alpha
      loadedView.isHidden = isHidden

      // important bits: on the main storyboard we have used some constraints, one of them (the height) is not related to any super view and must be copied
      loadedView.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
      for constraint in constraints {
        let firstItem = constraint.firstItem === self ? loadedView : constraint.firstItem
        let secondItem = constraint.secondItem === self ? loadedView : constraint.secondItem
        loadedView.addConstraint(NSLayoutConstraint(item: firstItem as Any, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: secondItem, attribute: constraint.secondAttribute, multiplier: constraint.multiplier, constant: constraint.constant))
      }
      return loadedView
    } else {
      return nil
    }
  }

  // MARK: - Interface builder

  #if TARGET_INTERFACE_BUILDER



  public override init(frame: CGRect) {
    super.init(frame: frame)
    let bundle = Bundle(for: type(of: self))
    let loadedView = bundle.loadNibNamed("DemoView", owner: nil, options: nil)?.first! as! UIView
    loadedView.autoresizingMask = autoresizingMask
    loadedView.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
    loadedView.clipsToBounds = clipsToBounds
    loadedView.alpha = alpha
    loadedView.isHidden = isHidden
    loadedView.frame = bounds
    addSubview(loadedView)
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  open override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    backgroundColor = UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.0)
  }

  open override func setValue(_ value: Any?, forKeyPath keyPath: String) {
    super.setValue(value, forKeyPath: keyPath)
  }

  #endif

}
