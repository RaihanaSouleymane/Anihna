
//  Anihna
//
//  Created by Raihana Souleymane on 4/26/20.
//  Copyright © 2020 Raihana Souleymane. All rights reserved.

import Foundation
import UIKit
 
 

open class SVGView: UIView {
    var shouldRoundCorners = true
    var imageView : UIImageView?
    open var backgroudColor : String = "FFFFFF"
    open var fileName: String? {
        didSet {
           // self.setImage(imageName: fileName!)
        }
    }
    
    
    public init(frame: CGRect, shouldRoundCorners : Bool = true) {
        self.shouldRoundCorners = shouldRoundCorners
        super.init(frame: frame)
        initializeView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        imageView = UIImageView(frame: CGRect(x:0, y:0, width: self.bounds.width , height: self.bounds.height ))
        self.addSubview((imageView)!)
        _ = imageView?.constrainFitInside(constrainInside: self)
        // imageView?.layer.borderWidth = 1
        imageView?.layer.masksToBounds = false
        // imageView?.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.size.width/2
        imageView?.clipsToBounds = true
    }
    

    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderWidth =  shouldRoundCorners ? 0.5 : 0
        self.layer.masksToBounds = false
        self.layer.borderColor = ANStyleGuideManager.Colors.DarkModeGrayBackground().cgColor
        self.layer.cornerRadius = shouldRoundCorners ? self.frame.size.width/2 : 0
        self.clipsToBounds = true
    }
}


public extension UIImage {
    class func imageWithColor(color: UIColor, alpha: CGFloat, width : CGFloat = 1, height: CGFloat = 1) -> UIImage {

        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context!.setFillColor(color.cgColor)
        context!.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }

    func addText(_ drawText: NSString, atPoint: CGPoint, textColor: UIColor?, textFont: UIFont?) -> UIImage {

        // Setup the font specific variables
        var _textColor: UIColor
        if textColor == nil {
            _textColor = UIColor.white
        } else {
            _textColor = textColor!
        }

        var _textFont: UIFont
        if textFont == nil {
            _textFont = ANStyleGuideManager.Fonts.Fields.Global1ContactName()
        } else {
            _textFont = textFont!
        }

        // Setup the image context using the passed image
        UIGraphicsBeginImageContext(size)

        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center

        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes :[NSAttributedString.Key : Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): _textFont,
            NSAttributedString.Key.foregroundColor: _textColor,
            NSAttributedString.Key.paragraphStyle: style,
        ]

        // Put the image into a rectangle as large as the original image
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))

        // Create a point within the space that is as bit as the image
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: size.width, height: size.height)

        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: textFontAttributes)

        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        // End the context now that we have the image we need
        UIGraphicsEndImageContext()

        //Pass the image back up to the caller
        return newImage!
    }
}

public extension UIImage {
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInMb:Int) -> UIImage? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }

        if let data = imgData {
            if (data.count < sizeInBytes) {
                return UIImage(data: data)
            }
        }
        return nil
    }

    func compressToData(_ expectedSizeInBytes:Int) -> Data? {
        let sizeInBytes = expectedSizeInBytes
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }

        return imgData
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let scale = targetSize.width  / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: targetSize.width, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}
