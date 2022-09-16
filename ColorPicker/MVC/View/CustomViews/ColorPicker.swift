//
//  ColorPickerClass.swift
//  ColorPicker
//
//  Created by Consultant on 11/09/22.
//

import Foundation

import UIKit

protocol ColorSelectionDelegate {
    func colorChange()
}

class ColorPicker: UIView, ColorWheelDelegate {
    
    var colorWheel: ColorWheel!
    var delegate: ColorSelectionDelegate?
    var color: UIColor!
    var hue: CGFloat = 1.0
    var saturation: CGFloat = 1.0
    var brightness: CGFloat = 1.0
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    open func setViewColor(_ color: UIColor) {
        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0, alpha: CGFloat = 0.0
        let ok: Bool = color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if (!ok) {
            print("ColorPicker: exception <The color provided to ColorPicker is not convertible to HSV>")
        }
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.color = color
        setup()
    }
    
    func setup() {
        // Remove all subviews
        let views = self.subviews
        for view in views {
            view.removeFromSuperview()
        }
      
        // Init new ColorWheel subview
        colorWheel = ColorWheel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), color: self.color)
        colorWheel.delegate = self
        // Add colorWheel as a subview of this view
        self.addSubview(colorWheel)
    }
    
    func hueAndSaturationSelected(_ hue: CGFloat, saturation: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.color = UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: 1.0)
    }
    
    func brightnessSelected(_ brightness: CGFloat) {
        self.brightness = brightness
        self.color = UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: 1.0)
        colorWheel.setViewBrightness(brightness)
    }
    
    func colorChange() {
        self.delegate?.colorChange()
    }
}

