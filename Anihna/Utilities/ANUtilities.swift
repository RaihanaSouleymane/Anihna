//
//  UIVIewController.swift
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.


import UIKit
import Foundation


class ANUtilities: NSObject {


    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.sizeToFit()

    return label.frame.height
}


    class func getApproximateAdjustedFontSize(with label: UILabel?) -> UIFont {
        if label?.adjustsFontSizeToFitWidth ?? false {
            var currentFont: UIFont? = label?.font
            let originalFontSize: CGFloat? = currentFont?.pointSize
            var currentSize: CGSize? = label?.text?.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: currentFont as Any])
            while (currentSize?.width ?? 0.0) > (label?.frame.size.width ?? 0.0) && (currentFont?.pointSize ?? 0.0) > ((originalFontSize ?? 0.0) * (label?.minimumScaleFactor ?? 0.0)) {
                currentFont = currentFont?.withSize((currentFont?.pointSize ?? 0.0) - 1)
                currentSize = label?.text?.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: currentFont as Any])
            }
            return currentFont!
        } else {
            return (label?.font)!
        }
    }

    class func blurTheView(theView: UIView, effectStyle: UIBlurEffect.Style? = UIBlurEffect.Style.light){
        var darkBlur:UIBlurEffect = UIBlurEffect()

        darkBlur = UIBlurEffect(style: effectStyle!) //extraLight, light, dark

        _ = UIVisualEffectView(effect: darkBlur)

        let vibrancy = UIVibrancyEffect(blurEffect: darkBlur)
        //
        let effectView = UIVisualEffectView(effect: darkBlur)

        let vibrantView = UIVisualEffectView(effect: vibrancy)
        theView.addSubview(vibrantView)
        theView.addSubview(effectView)
        _ = vibrantView.constrainFitInside(constrainInside: theView)
        _ = effectView.constrainFitInside(constrainInside: theView)

    }


   class func removeBlurFromView(theView: UIView){

        for subview in theView.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }

    }

    class func addIconToLabel(withLabel lbl: UILabel, withText text: NSMutableAttributedString, imageName: String?)-> NSAttributedString {

        let attachment = NSTextAttachment()
        let image =  UIImage(named: imageName!)?.withRenderingMode(.alwaysTemplate)
        attachment.image = image

        let imageOffsetY = -5
        attachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 20, height:20)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString:NSMutableAttributedString = text
        myString.append(attachmentString)
        lbl.isUserInteractionEnabled = true

        return myString
    }


   class func getFlag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }

    class func downloadImageData(fromUrl path: String,completion:@escaping (_ imagedata: Data?) -> Void){
        
        var data : Data?
        
        if let url = URL(string: path) {
            data = try? Data(contentsOf: url)
        }
        
        completion(data)
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }

    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }


    func allRanges(of aString: String,
                   options: String.CompareOptions = [],
                   range: Range<String.Index>? = nil,
                   locale: Locale? = nil) -> [Range<String.Index>] {

        //the slice within which to search
        let slice = (range == nil) ? self : String(self[range!])

        var previousEnd: String.Index? = self.startIndex
        var ranges = [Range<String.Index>]()


        while let r = slice.range(of: aString, options: options,
                                  range: previousEnd! ..< self.endIndex,
                                  locale: locale) {
                                    if previousEnd != self.endIndex { //don't increment past the end
                                        previousEnd = self.index(after: r.lowerBound)
                                    }
                                    ranges.append(r)
        }

        return ranges
    }


    func allRanges(of aString: String,
                   options: String.CompareOptions = [],
                   range: Range<String.Index>? = nil,
                   locale: Locale? = nil) -> [Range<Int>] {
        return allRanges(of: aString, options: options, range: range, locale: locale)
            .map(indexRangeToIntRange)
    }

    func indexToInt(_ index: String.Index) -> Int {
        return self.distance(from: self.startIndex, to: index)
    }

    func indexRangeToIntRange(_ range: Range<String.Index>) -> Range<Int> {
        return indexToInt(range.lowerBound) ..< indexToInt(range.upperBound)
    }

    func deletingPrefix(_ prefix: String) -> String {
            guard self.hasPrefix(prefix) else { return self }
            return String(self.dropFirst(prefix.count))
    }

    func getUrlsFromString ()-> [String] {
        // let text = "www.google.com. http://www.bla.com"
        var stringArray = [String]()
        let types: NSTextCheckingResult.CheckingType = .link
        let detector = try? NSDataDetector(types: types.rawValue)
        
        if let detect = detector {
            let matches = detect.matches(in: self, options: .reportCompletion, range: NSMakeRange(0, self.count))
            for match in matches {
                if let url = match.url {
                    stringArray.append("\(String(describing: url))")
                }
            }
        }
        return stringArray
    }
    func hasSpecialFormat ()-> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link, .phoneNumber, .address]
        if let detector = try? NSDataDetector(types: types.rawValue) {
            return detector.matches(in: self, options: .reportCompletion, range: NSMakeRange(0, self.count)).count > 0
        }
        return false
    }
    
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    func countInstances(of stringToFind: String) -> Int {
        var stringToSearch = self
        var count = 0
        while let foundRange = stringToSearch.range(of: stringToFind, options: .diacriticInsensitive) {
            stringToSearch = stringToSearch.replacingCharacters(in: foundRange, with: "")
            count += 1
        }
        return count
    }

}

extension StringProtocol where Index == String.Index {
    func nsRange<T: StringProtocol>(of string: T, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> NSRange? {
        guard let range = self.range(of: string, options: options, range: range ?? startIndex..<endIndex, locale: locale ?? .current) else { return nil }
        return NSRange(range, in: self)
    }
    func nsRanges<T: StringProtocol>(of string: T, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> [NSRange] {
        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end, let range = self.range(of: string, options: options, range: start..<end, locale: locale ?? .current) {
            ranges.append(NSRange(range, in: self))
            start = range.upperBound
        }
        return ranges
    }
}


extension NSMutableAttributedString {

    public func setAsLink(textToFind:String, linkURL:String) {//} -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedString.Key.link, value: linkURL, range: foundRange)
          //  return true
        }
       // return false
    }
}
extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat, rect: CGRect = CGRect.zero) {
        
        let border = CALayer()
        border.name = "customBorder"
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            if rect != CGRect.zero {
                border.frame = rect
                break
            }
            border.frame = CGRect(x:0, y:self.frame.height - thickness, width:self.frame.width, height:thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x:0, y:0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x:self.frame.width - thickness, y: 0, width: thickness, height:self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor
        
        self.addSublayer(border)
    }
}

extension NSMutableAttributedString {

    public func setAsLink(textToFind:String, linkURL:String) -> Bool {

        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedString.Key.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
