//
//  UIImage.swift
//  Resources
//
//  Copyright © 2020 DB1. All rights reserved.
//

import UIKit

extension UIImageView {

    func withBluer() {
        if let image = self.image {
            let inputImage = CIImage(cgImage: (image.cgImage)!)
            let filter = CIFilter(name: "CIGaussianBlur")
            filter?.setValue(inputImage, forKey: "inputImage")
            filter?.setValue(10, forKey: "inputRadius")
            let blurred = filter?.outputImage

            var newImageSize: CGRect = (blurred?.extent)!
            newImageSize.origin.x += ( newImageSize.size.width - (image.size.width) ) / 2
            newImageSize.origin.y += ( newImageSize.size.height - (image.size.height) ) / 2
            newImageSize.size = (image.size)

            let resultImage: CIImage = filter?.value(forKey: "outputImage") as! CIImage
            let context: CIContext = CIContext.init()
            let cgimg: CGImage = context.createCGImage(resultImage, from: newImageSize)!
            let blurredImage: UIImage = UIImage.init(cgImage: cgimg)
            self.image = blurredImage
        }
    }
}

extension UIImage {

    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

}

extension UIImage {

    static func with(_ name: String?, background: UIColor?) -> UIImage? {
         let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
         let nameLabel = UILabel(frame: frame)
         nameLabel.textAlignment = .center
         nameLabel.backgroundColor = background
         nameLabel.textColor = .white
         nameLabel.font = UIFont.boldSystemFont(ofSize: 40)
         nameLabel.text = name
         UIGraphicsBeginImageContext(frame.size)
          if let currentContext = UIGraphicsGetCurrentContext() {
             nameLabel.layer.render(in: currentContext)
             let nameImage = UIGraphicsGetImageFromCurrentImageContext()
             return nameImage
          }
          return nil
    }

}


extension UIImage {

    // From Material
    /**
     Creates a new image with the passed in color.
     - Parameter color: The UIColor to create the image from.
     - Returns: A UIImage that is the color passed in.
     */
    open func tint(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -size.height)

        context.setBlendMode(.multiply)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)
        color.setFill()
        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.withRenderingMode(.alwaysOriginal)
    }
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    static func blackened(image: UIImage) -> UIImage {
        UIGraphicsBeginImageContext(image.size)
        image.draw(at: CGPoint.zero)
        let context = UIGraphicsGetCurrentContext()

        // set fill gray and alpha
        context!.setFillColor(gray: 0, alpha: 0.5)
        context!.move(to: CGPoint(x: 0, y: 0))
        context!.fill(CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        context!.strokePath()
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()

        // end the graphics context
        UIGraphicsEndImageContext()

        return resultImage!

    }

    func colorized(with color: UIColor) -> UIImage? {
        guard
            let ciimage = CIImage(image: self),
            let colorMatrix = CIFilter(name: "CIColorMatrix")
            else { return nil }
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        colorMatrix.setDefaults()
        colorMatrix.setValue(ciimage, forKey: kCIInputImageKey)
        colorMatrix.setValue(CIVector(x: r, y: 0, z: 0, w: 0), forKey: "inputRVector")
        colorMatrix.setValue(CIVector(x: 0, y: g, z: 0, w: 0), forKey: "inputGVector")
        colorMatrix.setValue(CIVector(x: 0, y: 0, z: b, w: 0), forKey: "inputBVector")
        colorMatrix.setValue(CIVector(x: 0, y: 0, z: 0, w: a), forKey: "inputAVector")
        if let ciimage = colorMatrix.outputImage {
            return UIImage(ciImage: ciimage)
        }
        return nil
    }

    func monochrome(with color: UIColor, intensity: Float = 1.0) -> UIImage? {
        guard let ciImage = CIImage(image: self), let filter = CIFilter(name: "CIColorMonochrome") else {
            return nil
        }

        let ciColor = CIColor(color: color)
        filter.setDefaults()
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(ciColor, forKey: kCIInputColorKey)
        filter.setValue(intensity, forKey: kCIInputIntensityKey)
        if let output = filter.value(forKey: kCIOutputImageKey) as? CIImage {
            let filteredImage = UIImage(ciImage: output)
            return filteredImage
        }
//        if let outputImage = filter.outputImage {
//            return UIImage(ciImage: outputImage)
//        }
        return nil
    }

    func promocodeImage() -> UIImage? {
        guard
            let ciimage = CIImage(image: self),
            let colorMatrix = CIFilter(name: "CIColorMatrix")
            else { return nil }
        colorMatrix.setDefaults()
        colorMatrix.setValue(ciimage, forKey: kCIInputImageKey)
        colorMatrix.setValue(CIVector(x: 1, y: 0, z: 0, w: 0), forKey: "inputRVector")
        colorMatrix.setValue(CIVector(x: 0, y: 1, z: 0, w: 0), forKey: "inputGVector")
        colorMatrix.setValue(CIVector(x: 0, y: 0, z: 1, w: 0), forKey: "inputBVector")
        colorMatrix.setValue(CIVector(x: 0, y: 0, z: 0, w: 0.2), forKey: "inputAVector")

        let ciColor = CIColor(color: UIColor(red: 0, green: 140.0/255.0, blue: 1, alpha: 1))
        let filter = CIFilter(name: "CIColorMonochrome")!
        filter.setDefaults()
        filter.setValue(colorMatrix.outputImage, forKey: kCIInputImageKey)
        filter.setValue(ciColor, forKey: kCIInputColorKey)
        filter.setValue(1.0, forKey: kCIInputIntensityKey)
        if let output = filter.value(forKey: kCIOutputImageKey) as? CIImage {
            let filteredImage = UIImage(ciImage: output)
            return filteredImage
        }
        return nil
    }

    func resize(requestSize: CGSize) -> UIImage? {
        let size = self.size

        let widthRatio = requestSize.width / size.width
        let heightRatio = requestSize.height / size.height

        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        }
        else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let finalRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: finalRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}


