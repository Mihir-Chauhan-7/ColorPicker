//
//  ViewController.swift
//  ColorPicker
//
//  Created by Consultant on 11/09/22.
//

import UIKit

class ColorPalettViewController: UIViewController{
    
    //-----------------------------------------------------------------------------------------
    //MARK:- IBOutlet
    
    @IBOutlet private weak var imgPicker: ColorPicker!
    @IBOutlet private var segments: [SegmentView]!
    @IBOutlet private weak var lblPercenntage: UILabel!
    @IBOutlet private weak var brightnessSlider: UISlider!
    
    //-----------------------------------------------------------------------------------------
    //MARK:- Properties
    
    var selectedSegmwent: Int = 0 {
        didSet {
            self.updateSegmentSelection(index: selectedSegmwent)
        }
    }
    
    //-----------------------------------------------------------------------------------------
    //MARK:- Custom Methods
    
    func setupView() {
        DispatchQueue.main.async {
            self.brightnessSlider.value = 50
            self.imgPicker.delegate = self
            self.imgPicker.setViewColor(self.segments[0].segmentColor)
            self.segments.forEach({ segment in
                segment.colorView.layer.cornerRadius = segment.colorView.bounds.height / 2
                segment.delegate = self
            })
            
            self.brightnessSlider.value = Float(self.imgPicker.brightness * 100)
            self.brightnessChanged(self.brightnessSlider)
        }
    }
    
    func updateSegmentSelection(index: Int) {
        self.segments.forEach { segment in
            segment.isSelected = false
        }
        
        self.segments[index].isSelected = true
        self.imgPicker.color = self.segments[index].segmentColor
        self.imgPicker.setViewColor(self.imgPicker.color)
        self.brightnessSlider.value = Float(self.imgPicker.brightness * 100)
        self.brightnessChanged(self.brightnessSlider)
    }
    
    func updateSegmentColor(color: UIColor) {
        self.segments[self.selectedSegmwent].segmentColor = color
    }
    
    //-----------------------------------------------------------------------------------------
    //MARK:- IBAction
    
    @IBAction func brightnessChanged(_ sender: UISlider) {
        DispatchQueue.main.async {
            let thumbPosition = sender.thumbRect(forBounds: self.brightnessSlider.bounds, trackRect: self.brightnessSlider.bounds, value: self.brightnessSlider.value)
            self.lblPercenntage.center = CGPoint(x: thumbPosition.maxX, y: self.lblPercenntage.frame.midY)
            self.lblPercenntage.text = "\(Int(self.brightnessSlider.value.rounded()))%"
            print(CGFloat(self.brightnessSlider.value.rounded()) / 100)
            self.imgPicker.brightnessSelected(self.brightnessSlider.getBrightnessFromPoint(point: self.brightnessSlider.getXCoordinate(thumbPosition.origin.x)))
            self.colorChange()
        }
        
    }

    
    //-----------------------------------------------------------------------------------------
    //MARK:- Memory Management
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //-----------------------------------------------------------------------------------------
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
}

//-----------------------------------------------------------------------------------------
//MARK:- Delegate Segment & Color Picker

extension ColorPalettViewController: SegmentDelegate, ColorSelectionDelegate {
    
    func colorChange() {
        self.updateSegmentColor(color: self.imgPicker.color)
    }

    func segmentSelectionChange(segmentIndex: Int) {
        self.selectedSegmwent = segmentIndex
    }
}
