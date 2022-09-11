//
//  UISlider+Helper.swift
//  ColorPicker
//
//  Created by Consultant on 11/09/22.
//

import UIKit
extension UISlider {
    
    func getBrightnessFromPoint(point: CGFloat) -> CGFloat {
        // Get the brightness value for a given point
        return point/self.frame.width
    }
    
    func getXCoordinate(_ coord: CGFloat) -> CGFloat {
        // Offset the x coordinate to fit the view
        if (coord < 1) {
            return 1
        }
        if (coord > frame.size.width - 1 ) {
            return frame.size.width - 1
        }
        return coord
    }
}
