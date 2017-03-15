/*
 The MIT License (MIT)
 
 Copyright (c) 2017 Maiko Hermans
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit

@IBDesignable
public class MHWalkthroughPageControl: UIControl {
    
    var selectedView: UIView?
    var dots: [UIView?] = []
    
    @IBInspectable public var dotCount: Int = 0 { didSet { setup() } }
    
    @IBInspectable public var dotSize: CGFloat = 7
    
    @IBInspectable public var dotSpacing: CGFloat = 10
    
    @IBInspectable public var dotColor: UIColor = UIColor.clear {
        didSet {
            for dot in dots {
                if let dot = dot, dot != selectedView {
                    dot.backgroundColor = dotColor
                }
            }
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            for dot in dots {
                if let dot = dot, dot != selectedView {
                    dot.layer.borderWidth = borderWidth
                }
            }
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            for dot in dots {
                if let dot = dot, dot != selectedView {
                    dot.layer.borderColor = borderColor.cgColor
                }
            }
        }
    }
    
    @IBInspectable public var dotSelectedColor: UIColor = UIColor.black {
        didSet {
            if let dot = selectedView {
                dot.backgroundColor = dotSelectedColor
            }
        }
    }
    
    @IBInspectable public var dotSelectedBorderColor: UIColor = UIColor.clear {
        didSet {
            if let dot = selectedView {
                dot.layer.borderColor = dotSelectedBorderColor.cgColor
            }
        }
    }
    
    @IBInspectable public var dotSelectedBorderWidth: CGFloat = 0.0 {
        didSet {
            if let dot = selectedView {
                dot.layer.borderWidth = dotSelectedBorderWidth
            }
        }
    }
    
    var selectedDot: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func cleanViews() {
        for dot in dots {
            if let dot = dot {
                dot.removeFromSuperview()
                dots[dot.tag] = nil
            }
        }
    }
    
    func setup() {
        cleanViews()
        
        dots = Array(repeating: nil, count: dotCount)
        for index in 0..<dotCount {
            let dot = UIView()
            
            let xPos = (CGFloat(index) * dotSize) + (CGFloat(index) * dotSpacing)
            let yPos = (frame.height - dotSize) / 2
            dot.frame = CGRect(x: xPos, y: yPos, width: dotSize, height: dotSize)
            
            dot.backgroundColor = dotColor
            dot.layer.borderColor = borderColor.cgColor
            dot.layer.borderWidth = borderWidth
            dot.layer.cornerRadius = dotSize / 2
            
            addSubview(dot)
            dot.tag = index
            dots[index] = dot
        }
        selectedDot = 0
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        var xPos: CGFloat = 0.0
        var yPos: CGFloat = 0.0
        let frameWidth = frame.width
        let totalWidth = CGFloat(dotCount) * dotSize
        let totalSpacing = CGFloat(dotCount - 1) * dotSpacing
        
        let drawStartPosition: CGFloat = (frameWidth - (totalWidth + totalSpacing)) / 2
        for dot in dots {
            if let dot = dot {
                let index = CGFloat(dot.tag)
                xPos = drawStartPosition + ((index * dotSize) + (index * dotSpacing))
                yPos = (frame.height - dotSize) / 2
            }
            dot?.frame = CGRect(x: xPos, y: yPos, width: dotSize, height: dotSize)
        }
    }
    
    func displayNewSelectedIndex() {
        if selectedDot < 0 || selectedDot > dotCount - 1 { return }
        
        for dot in dots {
            if let dot = dot {
                if dot.tag == selectedDot {
                    selectedView = dot
                    setSelectedStyle(view: dot, animated: true)
                } else {
                    setNormalStyle(view: dot, animated: true)
                }
            }
        }
    }
    
    func setSelectedStyle(view: UIView, animated: Bool) {
        view.backgroundColor = dotSelectedColor
        view.layer.borderWidth = dotSelectedBorderWidth
        view.layer.borderColor = dotSelectedBorderColor.cgColor
    }
    
    func setNormalStyle(view: UIView, animated: Bool) {
        view.backgroundColor = dotColor
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColor.cgColor
    }
}
