//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.
//
import UIKit

/** This object is used as an inputAccessoryView to track frame changes and update the parent accordingly. Used in this project to keep the input view above the keyboard at all times. */
public class ANKeyboardPlaceholderView : UIView {
    
    public static var keyboardHeight : CGFloat = 0
    
    public var observerAdded = false
    public var inputAccessoryViewFrameChanged : ((CGRect) -> ())?
    
    func inputAccessorySuperviewFrame() -> CGRect {
        return self.superview!.frame
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        
        if observerAdded {
//            self.superview?.removeObserver(self, forKeyPath: "frame", context: nil)
            self.superview?.removeObserver(self, forKeyPath: "center", context: nil)
        }
        
//        newSuperview?.addObserver(self, forKeyPath: "frame", options: [], context: nil)
        newSuperview?.addObserver(self, forKeyPath: "center", options: [], context: nil)
        observerAdded = true
        
        super.willMove(toSuperview: newSuperview)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (object as! UIView) == self.superview && (keyPath == "frame" || keyPath == "center") {
            if self.inputAccessoryViewFrameChanged != nil {
                let frame = self.superview!.frame
                self.inputAccessoryViewFrameChanged!(frame)
            }
        }
    }
    
    deinit {
        if observerAdded {
            self.superview?.removeObserver(self, forKeyPath: "frame", context: nil)
            self.superview?.removeObserver(self, forKeyPath: "center", context: nil)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if let closure = self.inputAccessoryViewFrameChanged, let frame = self.superview?.frame {
            closure(frame)
        }
    }
}
