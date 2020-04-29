//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.



import UIKit

// Key:
//  - constrainInsideXXX - constrain this view to a parent
//  - constrainXXX - constrain this view to a sibling
//

public extension UIView {
    
    // MARK: First, some easy access to frame values
    var x: CGFloat {
        return self.frame.origin.x
    }
    
    var y: CGFloat {
        return self.frame.origin.y
    }
    
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var bwidth: CGFloat {
        return self.bounds.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
    
    var bheight: CGFloat {
        return self.bounds.size.height
    }
    
    var right: CGFloat {
        return x + width
    }
    
    var bottom: CGFloat {
        return y + height
    }
    
    // MARK: These don't fit the key above - they do various size/inside constraints
    //
    
    func constrainToRightEdgeOf(constrainInside: UIView, offset : CGFloat) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainRight(constrainTo: constrainInside, amount: offset)
    }
    
    func constrainToLeftEdgeOf(constrainInside: UIView, offset : CGFloat) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainLeft(constrainTo: constrainInside, amount: offset)
    }
    
    func constrainLeftToRightOf(constrainInside: UIView, offset: CGFloat) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainLeftRight(constrainTo: constrainInside, amount: offset)
    }
    
    func constrainRightToLeftOf(constrainInside: UIView, offset: CGFloat) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainRightLeft(constrainTo: constrainInside, amount: offset)
    }
    
    func constrainFitInside(constrainInside: UIView) -> [NSLayoutConstraint] {
        self.prepForConstraints()
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(self.doConstrainLeft(constrainTo: constrainInside))
        constraints.append(self.doConstrainTop(constrainTo: constrainInside))
        constraints.append(self.doConstrainWidth(constrainTo: constrainInside))
        constraints.append(self.doConstrainHeight(constrainTo: constrainInside))
        
        return constraints
    }
    
    func constrainFitInsideEdges(constrainInside: UIView) -> [NSLayoutConstraint] {
        self.prepForConstraints()
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(self.doConstrainLeft(constrainTo: constrainInside))
        constraints.append(self.doConstrainTop(constrainTo: constrainInside))
        constraints.append(self.doConstrainRight(constrainTo: constrainInside))
        constraints.append(self.doConstrainBottom(constrainTo: constrainInside))
        
        return constraints
    }
    
    func constrainFitInside(constrainInside: UIView, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        self.prepForConstraints()
        
        var constraints = [NSLayoutConstraint]()
        
        let left = self.doConstrainLeft(constrainTo: constrainInside, amount: insets.left)
        left.identifier = "left"
        constraints.append(left)
        
        let top = self.doConstrainTop(constrainTo: constrainInside, amount: insets.top)
        top.identifier = "top"
        constraints.append(top)
        
        let right = self.doConstrainRight(constrainTo: constrainInside, amount: insets.right)
        right.identifier = "right"
        constraints.append(right)
        
        let bottom = self.doConstrainBottom(constrainTo: constrainInside, amount: insets.bottom)
        bottom.identifier = "bottom"
        constraints.append(bottom)
        
        return constraints
    }
    
    // don't fit bottom
    func constrainFitInsideTLR(constrainInside: UIView) -> [NSLayoutConstraint] {
        self.prepForConstraints()
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(self.doConstrainTop(constrainTo: constrainInside))
        constraints.append(self.doConstrainLeft(constrainTo: constrainInside))
        constraints.append(self.doConstrainRight(constrainTo: constrainInside))
        
        return constraints
    }
    
    func constrainSize(width: CGFloat, height: CGFloat) -> (NSLayoutConstraint?, NSLayoutConstraint?) {
        self.prepForConstraints()
        
        return (self.doConstrainWidthValue(amount: width), self.doConstrainHeightValue(amount: height))
    }
    
    func constrainCenterInside(constrainInside: UIView, offsetX: CGFloat=0.0, offsetY: CGFloat=0.0) {
        self.prepForConstraints()
        
        _ = self.doConstrainCenterX(constrainTo: constrainInside, amount: offsetX)
        _ = self.doConstrainCenterY(constrainTo: constrainInside, amount: offsetY)
    }
    
    func constrainCenterHorizontallyInside(constrainInside: UIView) {
        self.prepForConstraints()
        _ = self.doConstrainCenterX(constrainTo: constrainInside)
    }
    
    func constrainCenterVerticallyInside(constrainInside: UIView) {
        self.prepForConstraints()
        _ = self.doConstrainCenterY(constrainTo: constrainInside)
    }
    
    func constrainCenterVerticallyInside(constrainInside: UIView, leftOffset: CGFloat, rightOffset: CGFloat) {
        self.prepForConstraints()
        
        _ = self.doConstrainLeft(constrainTo: constrainInside, amount: leftOffset)
        _ = self.doConstrainRight(constrainTo: constrainInside, amount: rightOffset)
        _ = self.doConstrainCenterY(constrainTo: constrainInside)
    }
    
    func constrainCenterYInside(constrainInside: UIView) {
        self.prepForConstraints()
        
        _ = self.doConstrainCenterY(constrainTo: constrainInside, amount: 0)
    }
    
    func constrainCenterXInside(constrainInside: UIView) {
        self.prepForConstraints()
        
        _ = self.doConstrainCenterX(constrainTo: constrainInside, amount: 0)
    }
    
    func constrainYCenter(to: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainCenterY(constrainTo: to, amount: offset)
    }
    
    func constrainXCenter(to: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainCenterX(constrainTo: to, amount: offset)
    }
    
    // MARK: Stacks
    //
    
    // constrain the parent's height to fit the contents of the children
    func constrainVerticalStackForContainer(views: [UIView], sizes: [CGFloat], lineSpacing: CGFloat, edgeInsets: UIEdgeInsets?) {
        if views.count == 0 || views.count != sizes.count {
            // nothing to do
            return
        }
        
        self.prepForConstraints()
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        var bottomInset: CGFloat = 0
        var rightInset: CGFloat = 0
        
        if let edgeInsets = edgeInsets {
            x = edgeInsets.left
            y = edgeInsets.top
            bottomInset = edgeInsets.bottom
            rightInset = edgeInsets.right
        }
        
        for (index, view) in views.enumerated() {
            view.constrainInsideTopLeft(constrainInside: self, amountX: x, amountY: y)
            
            y += sizes[index]
            
            if index == views.count-1 {
                if let edgeInsets = edgeInsets {
                    y += edgeInsets.bottom
                }
                
                view.constrainInsideBottomLeft(constrainInside: self, amountX: x, amountY: bottomInset)
            } else {
                y += lineSpacing
            }
            
            _ = view.constrainHeight(height: sizes[index])
            _ = view.constrainToWidth(constrainTo: self, amount: -x-rightInset)
        }
    }
    
    // MARK: Aspect
    func constrainAspect(ratio: CGFloat) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainAspect(amount: ratio)
    }
    
    // MARK: Width
    //
    
    func constrainWidthGreaterOrEqual(width: CGFloat) -> NSLayoutConstraint {
        self.prepForConstraints()
        let constraint = self.doConstrainWidthValue(amount: width, relation: .greaterThanOrEqual)
        
        return constraint
    }
    
    // match the left anchor and width of another view
    func constrainInsideLeftWidth(constrainInside: UIView) {
        self.prepForConstraints()
        
        _ = self.doConstrainLeft(constrainTo: constrainInside)
        _ = self.doConstrainWidth(constrainTo: constrainInside)
    }
    
    func constrainInsideCenterWidth(constrainInside: UIView, multiplier: CGFloat=1.0) {
        self.prepForConstraints()
        
        _ = self.doConstrainCenterX(constrainTo: constrainInside)
        _ = self.doConstrainWidth(constrainTo: constrainInside, multiplier: multiplier)
    }
    
    // match width value
    func constrainToWidth(constrainTo: UIView, amount: CGFloat=0.0, multiplier: CGFloat=1.0) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainWidth(constrainTo: constrainTo, amount: amount, multiplier: multiplier)
    }
    
    // constant value
    func constrainWidth(width: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainWidthValue(amount: width, relation: relation)
    }
    
    func constrainWidthToParent(parent: UIView, percentage : CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return doConstrainWidth(constrainTo: parent, amount: 0, multiplier: percentage, relation: relation)
    }
    
    func constrainHeightToParent(parent: UIView, percentage : CGFloat) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return doConstrainHeight(constrainTo: parent, amount: 0, multiplier: percentage)
    }
    
    // MARK: Height
    //
    
    func constrainInsideRight(constrainInside: UIView, amount : CGFloat=0.0) {
        self.prepForConstraints()
        
        _ = self.doConstrainRight(constrainTo: constrainInside, amount: amount)
    }
    
    // MARK: Height
    //
    
    func constrainInsideRightHeight(constrainInside: UIView, multiplier: CGFloat=1.0) {
        self.prepForConstraints()
        
        _ = self.doConstrainTop(constrainTo: constrainInside)
        _ = self.doConstrainHeight(constrainTo: constrainInside, multiplier: multiplier)
    }
    
    func constrainHeight(height: CGFloat, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.prepForConstraints()
        let constraint = self.doConstrainHeightValue(amount: height, relation: relation)

        return constraint
    }
    
    func constrainHeightGreaterOrEqual(height: CGFloat) -> NSLayoutConstraint {
        self.prepForConstraints()
        let constraint = self.doConstrainHeightValue(amount: height, relation: .greaterThanOrEqual)
        
        return constraint
    }
    
    // match height value
    func constrainToHeight(constrainTo: UIView, amount: CGFloat=0.0, multiplier: CGFloat=1.0) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainHeight(constrainTo: constrainTo, amount: amount, multiplier: multiplier)
    }
    
    // match left value
    func constrainToLeft(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainLeft(constrainTo: constrainTo, amount: amount)
    }
    
    // match right value
    func constrainToRight(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainRight(constrainTo: constrainTo, amount: -amount)
    }
    
    // match top value
    func constrainToTop(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainTop(constrainTo: constrainTo, amount: amount)
    }
    
    // match bottom value
    func constrainToBottom(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainBottom(constrainTo: constrainTo, amount: amount)
    }
    
    func constrainToBottomSafeArea(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        self.prepForConstraints()
        return self.doConstrainSafeAreaBottomAnchor(constrainTo: constrainTo, amount: amount)
    }
    
    // MARK: Inside parent edges
    //
    
    func constrainInsideTop(constrainInside: UIView, amount: CGFloat) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainTop(constrainTo: constrainInside, amount: amount)
    }
    
    func constrainInsideBottom(constrainInside: UIView, amount: CGFloat) {
        self.prepForConstraints()
        
        _ = self.doConstrainBottom(constrainTo: constrainInside, amount: amount)
    }
    
    func constrainInsideTopLeft(constrainInside: UIView, amountX: CGFloat=0, amountY: CGFloat=0) {
        self.prepForConstraints()
        
        _ = self.doConstrainTop(constrainTo: constrainInside, amount: amountY)
        _ = self.doConstrainLeft(constrainTo: constrainInside, amount: amountX)
    }
    
    func constrainInsideLeftCenter(constrainInside: UIView, amount: CGFloat) {
        self.prepForConstraints()
        
        _ = self.doConstrainCenterY(constrainTo: constrainInside)
        _ = self.doConstrainLeft(constrainTo: constrainInside, amount: amount)
    }
    
    func constrainInsideTopCenter(constrainInside: UIView, amount: CGFloat) {
        self.prepForConstraints()
        
        _ = self.doConstrainTop(constrainTo: constrainInside, amount: amount)
        _ = self.doConstrainCenterX(constrainTo: constrainInside)
    }
    
    func constrainInsideTopRight(constrainInside: UIView, amountX: CGFloat, amountY: CGFloat) {
        self.prepForConstraints()
        
        _ = self.doConstrainTop(constrainTo: constrainInside, amount: amountY)
        _ = self.doConstrainRight(constrainTo: constrainInside, amount: -amountX)
    }
    
    func constrainInsideRightCenter(constrainInside: UIView, amount: CGFloat) {
        self.prepForConstraints()
        
        _ = self.doConstrainCenterY(constrainTo: constrainInside)
        _ = self.doConstrainRight(constrainTo: constrainInside, amount: -amount)
    }
    
    func constrainInsideBottomLeft(constrainInside: UIView, amountX: CGFloat, amountY: CGFloat) {
        self.prepForConstraints()
        
        _ = self.doConstrainBottom(constrainTo: constrainInside, amount: -amountY)
        _ = self.doConstrainLeft(constrainTo: constrainInside, amount: amountX)
    }
    
    func constrainInsideBottomRight(constrainInside: UIView, amountX: CGFloat, amountY: CGFloat) {
        self.prepForConstraints()
        
        _ = self.doConstrainBottom(constrainTo: constrainInside, amount: -amountY)
        _ = self.doConstrainRight(constrainTo: constrainInside, amount: -amountX)
    }
    
    func constrainInsideBottomCenter(constrainInside: UIView, amount: CGFloat) {
        self.prepForConstraints()
        
        _ = self.doConstrainBottom(constrainTo: constrainInside, amount: -amount)
        _ = self.doConstrainCenterX(constrainTo: constrainInside)
    }
    
    // MARK: Attach to a sibling
    //
    
    // put left of a sibling
    func constrainLeft(constrainTo: UIView, amount: CGFloat, offsetY: CGFloat=0.0) {
        self.prepForConstraints()
        
        _ = self.doConstrainRightLeft(constrainTo: constrainTo, amount: -amount)
        _ = self.doConstrainTop(constrainTo: constrainTo, amount: offsetY)
    }
    
    // put left of a sibling, and centered vertically
    func constrainLeftCentered(constrainTo: UIView, amount: CGFloat=0.0) {
        self.prepForConstraints()
        
        _ = self.doConstrainRightLeft(constrainTo: constrainTo, amount: -amount)
        _ = self.doConstrainCenterY(constrainTo: constrainTo)
    }
    
    // put right of a sibling
    func constrainRight(constrainTo: UIView, amount: CGFloat, offsetY: CGFloat=0.0) {
        self.prepForConstraints()
        
        _ = self.doConstrainLeftRight(constrainTo: constrainTo, amount: amount)
        _ = self.doConstrainTop(constrainTo: constrainTo, amount: offsetY)
    }
    
    // put right of a sibling, and centered vertically
    func constrainRightCentered(constrainTo: UIView, amount: CGFloat=0.0) {
        self.prepForConstraints()
        
        _ = self.doConstrainLeftRight(constrainTo: constrainTo, amount: amount)
        _ = self.doConstrainCenterY(constrainTo: constrainTo)
    }
    
    // put above a sibling
    func constrainAbove(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainBottomTop(constrainTo: constrainTo, amount: amount)
    }
    
    // put above a sibling, centered horizontally
    func constrainAboveCentered(constrainTo: UIView, amount: CGFloat, centerReference: UIView?=nil, offsetX: CGFloat?=0.0) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        var offX: CGFloat = 0.0
        
        if let ox = offsetX {
            offX = ox
        }
        
        if let ref = centerReference {
             _ = self.doConstrainCenterX(constrainTo: ref, amount: offX)
        } else {
            _ = self.doConstrainCenterX(constrainTo: constrainTo, amount: offX)
        }
        
        let topConstraint = self.doConstrainBottomTop(constrainTo: constrainTo, amount: -amount)
        
        return topConstraint
    }
    
    // put below a sibling
    func constrainBelow(constrainTo: UIView, amount: CGFloat) -> NSLayoutConstraint {
        self.prepForConstraints()
        
        return self.doConstrainTopBottom(constrainTo: constrainTo, amount: amount)
    }
    
    // put below a sibling, centered horizontally
    func constrainBelowCentered(constrainTo: UIView, amount: CGFloat, centerReference: UIView?=nil, offsetX: CGFloat?=0.0) {
        self.prepForConstraints()
        
        var offX: CGFloat = 0.0
        
        if let ox = offsetX {
            offX = ox
        }
        
        if let ref = centerReference {
            _ = self.doConstrainCenterX(constrainTo: ref, amount: offX)
        } else {
            _ = self.doConstrainCenterX(constrainTo: constrainTo, amount: offX)
        }
        
        _ = self.doConstrainTopBottom(constrainTo: constrainTo, amount: amount)
    }
    
    // put below, aligned to the left side of the sibling
    func constrainBelowLeft(constrainTo: UIView, amount: CGFloat, belowReference: UIView?=nil, offsetX: CGFloat?=0.0) {
        self.prepForConstraints()
        
        if let ref = belowReference {
            _ = self.doConstrainTopBottom(constrainTo: ref, amount: amount)
        } else {
            _ = self.doConstrainTopBottom(constrainTo: constrainTo, amount: amount)
        }
        
        if let offX = offsetX {
            _ = self.doConstrainLeft(constrainTo: constrainTo, amount: offX)
        } else {
            _ = self.doConstrainLeft(constrainTo: constrainTo)
        }
    }
    
    // put below, aligned to the right of the sibing
    func constrainBelowRight(constrainTo: UIView, amount: CGFloat) {
        self.prepForConstraints()
        
        _ = self.doConstrainRight(constrainTo: constrainTo)
        _ = self.doConstrainTopBottom(constrainTo: constrainTo, amount: amount)
    }
    
    
    // MARK: - Private
    //
    
    private func prepForConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func doConstrainLeft(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        var constraint : NSLayoutConstraint
        
        constraint = self.leftAnchor.constraint(equalTo: constrainTo.leftAnchor, constant: amount)
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainRight(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        var constraint : NSLayoutConstraint
        
        constraint = self.rightAnchor.constraint(equalTo: constrainTo.rightAnchor, constant: amount)
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainTop(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        
        var constraint : NSLayoutConstraint
        
        constraint = self.topAnchor.constraint(equalTo: constrainTo.safeAreaLayoutGuide.topAnchor, constant: amount)
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainBottom(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        var constraint : NSLayoutConstraint
        
        constraint = self.bottomAnchor.constraint(equalTo: constrainTo.safeAreaLayoutGuide.bottomAnchor, constant: amount)
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainSafeAreaBottomAnchor(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        
        var constraint : NSLayoutConstraint
        
        let guide = constrainTo.safeAreaLayoutGuide
        constraint = self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: amount)
        constraint.isActive = true

        self.superview!.addConstraint(constraint)
        
        return constraint
    }
    
    private func doConstrainWidth(constrainTo: UIView, amount: CGFloat=0.0, multiplier: CGFloat=1.0, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        
        if relation == .equal {
            constraint = self.widthAnchor.constraint(equalTo: constrainTo.safeAreaLayoutGuide.widthAnchor, multiplier: multiplier, constant: amount)
        } else if relation == .greaterThanOrEqual {
            constraint = self.widthAnchor.constraint(greaterThanOrEqualTo: constrainTo.safeAreaLayoutGuide.widthAnchor, multiplier: multiplier, constant: amount)
        } else  {
            constraint = self.widthAnchor.constraint(lessThanOrEqualTo: constrainTo.safeAreaLayoutGuide.widthAnchor, multiplier: multiplier, constant: amount)
        }
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainWidthValue(amount: CGFloat=0.0, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint

        if relation == .equal {
            constraint = self.widthAnchor.constraint(equalToConstant: amount)
        } else if relation == .greaterThanOrEqual {
            constraint = self.widthAnchor.constraint(greaterThanOrEqualToConstant: amount)
        } else {
            constraint = self.widthAnchor.constraint(lessThanOrEqualToConstant: amount)
        }
        
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainHeight(constrainTo: UIView, amount: CGFloat=0.0, multiplier: CGFloat=1.0) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        
        constraint = self.heightAnchor.constraint(equalTo: constrainTo.safeAreaLayoutGuide.heightAnchor, multiplier: multiplier, constant: amount)
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainHeightValue(amount: CGFloat=0.0, relation: NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        
        if relation == .equal {
            constraint = self.heightAnchor.constraint(equalToConstant: amount)
        } else if relation == .greaterThanOrEqual {
            constraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: amount)
        } else {
            constraint = self.heightAnchor.constraint(lessThanOrEqualToConstant: amount)
        }
        
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainCenterX(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint

        constraint = self.centerXAnchor.constraint(equalTo: constrainTo.safeAreaLayoutGuide.centerXAnchor, constant: amount)
        constraint.isActive = true
        return constraint
    }
    
    private func doConstrainCenterY(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        
        constraint = self.centerYAnchor.constraint(equalTo: constrainTo.safeAreaLayoutGuide.centerYAnchor, constant: amount)
        constraint.isActive = true
        return constraint
    }
    
    private func doConstrainLeftRight(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        var constraint : NSLayoutConstraint
        
        constraint = self.leftAnchor.constraint(equalTo: constrainTo.safeAreaLayoutGuide.rightAnchor, constant: amount)
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainRightLeft(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        
        constraint = self.rightAnchor.constraint(equalTo: constrainTo.safeAreaLayoutGuide.leftAnchor, constant: amount)
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainTopBottom(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        
        constraint = self.topAnchor.constraint(equalTo: constrainTo.safeAreaLayoutGuide.bottomAnchor, constant: amount)
        constraint.isActive = true
        
        return constraint
    }
    
    private func doConstrainBottomTop(constrainTo: UIView, amount: CGFloat=0.0) -> NSLayoutConstraint {
        var constraint: NSLayoutConstraint
        
        constraint = self.bottomAnchor.constraint(equalTo: constrainTo.safeAreaLayoutGuide.topAnchor, constant: amount)
        constraint.isActive = true
        
        return constraint
    }
    
    // iOS 8.0 and previous - convenience
    //
    private func doConstrainThis(constrainTo: UIView, amount: CGFloat, attribute: NSLayoutConstraint.Attribute, multiplier: CGFloat=1.0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: NSLayoutConstraint.Relation.equal, toItem: constrainTo, attribute: attribute, multiplier: multiplier, constant: amount)
        self.superview!.addConstraint(constraint)
        
        return constraint
    }
    
    private func doConstrainThisValue(amount: CGFloat, attribute: NSLayoutConstraint.Attribute, relation : NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: amount)
        self.addConstraint(constraint)
        
        return constraint
    }
    
    private func doConstrainAspect(amount: CGFloat) -> NSLayoutConstraint {

        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: .height, multiplier: amount, constant: 0)
        self.addConstraint(constraint)
        
        return constraint
    }
    
    private func doConstrainThisToThis(constrainTo: UIView, amount: CGFloat, attribute: NSLayoutConstraint.Attribute, toAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: NSLayoutConstraint.Relation.equal, toItem: constrainTo, attribute: toAttribute, multiplier: 1, constant: amount)
        self.superview!.addConstraint(constraint)
        
        return constraint
    }
}


public extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
