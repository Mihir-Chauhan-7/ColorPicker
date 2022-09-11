//
//  TopNavigation.swift
//  JustBooks
//
//  Created by Mihir Chauhan on 12/01/22.
//

import Foundation
import UIKit

protocol SegmentDelegate {
    func segmentSelectionChange(segmentIndex: Int)
}

@IBDesignable
class SegmentView: UIView {

    @IBOutlet weak var colorView: UIView!
    
    let nibName = "SegmentView"
    var delegate: SegmentDelegate?
    var contentView: UIView?
    
    @IBInspectable var segmentIndex: Int = 0
    
    @IBInspectable var segmentColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            self.colorView.backgroundColor = self.segmentColor
        }
    }
    
    @IBInspectable var isSelected: Bool = false {
        didSet {
            self.contentView?.backgroundColor = UIColor(named: self.isSelected ? "#3b3b3b_lightGrey" : "#2c2c2c_grey")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.contentView?.prepareForInterfaceBuilder()
    }
    
    @IBAction func btnSelectClicked(_ sender: UIButton) {
        self.delegate?.segmentSelectionChange(segmentIndex: self.segmentIndex)
    }
}

extension SegmentView: UISearchBarDelegate {
    
    
}
