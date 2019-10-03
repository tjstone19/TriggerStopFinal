//
//  UIImageExtension.swift
//  TriggerStop
//
//  Created by T.J. Stone on 9/30/19.
//  Copyright © 2019 T.J. Stone. All rights reserved.
//

import UIKit


/**
 * This extension adds the ability to crop UIImages.
 */
extension UIImage {
    
    /**
     * Crops the UIImage to fit the provided width and height dimensions.
     *
     * - parameter width: New width.
     * - parameter height: New height.
     *
     * - returns: A new UIImage with the provided width and height.
     */
    func cropToBounds(width: CGFloat, height: CGFloat) -> UIImage {
        
        let cgimage = self.cgImage!
        let contextImage: UIImage = UIImage(cgImage: cgimage)
        let contextSize: CGSize = contextImage.size
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRect(
            x: posX,
            y: posY,
            width: cgwidth,
            height: cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImage = cgimage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the
        // original orientation.
        let image: UIImage = UIImage(
            cgImage: imageRef,
            scale: self.scale,
            orientation: self.imageOrientation)
        
        return image
    }
}
