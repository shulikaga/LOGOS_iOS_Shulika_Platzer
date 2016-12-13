//
//  progressBar.swift
//  LOGOSIos
//
//  Created by Ganna Shulika on 04/12/2016.
//  Copyright © 2016 Ganna Shulika. All rights reserved.
//

import Foundation

import UIKit

class ProgressBar : UIView {
    let colorA = UIColor.green
    let colorB = UIColor.red
    let colorC = UIColor.lightGray
    let cornerRadius = 5
    
    var fracA = CGFloat(0.0), fracB = CGFloat(0.0)
    
    func updateValues(_ fracA: Double, fracB: Double) {
        self.fracA = CGFloat(fracA)
        self.fracB = CGFloat(fracB)
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        let bpC = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), cornerRadius: CGFloat(cornerRadius))
        colorC.setFill()
        bpC.fill()
        
        let bpB = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width * (fracA + fracB), height: self.frame.height), cornerRadius: 5)
        colorB.setFill()
        bpB.fill()
        
        let bpA = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width * fracA, height: self.frame.height), cornerRadius: 5)
        
        colorA.setFill()
        bpA.fill()
    }
}
