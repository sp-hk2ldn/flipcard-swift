//
//  CustomView.swift
//  LongExperiment
//
//  Created by cltsang on 6/10/15.
//  Copyright (c) 2015 NBition Development Limited. All rights reserved.
//
// xcode set-up: http://iphonedev.tv/blog/2014/12/15/create-an-ibdesignable-uiview-subclass-with-code-from-an-xib-file-in-xcode-6
// code: http://stackoverflow.com/questions/29288931/swift-class-variable-crashing-interface-builder-live-rendering

import Foundation
import UIKit

@IBDesignable public class CustomView : UIView {
    let nibName = "CustomView";
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var backView: UIView!
    
    var flipped = false
    
    @IBAction func tapToFlip(sender: UITapGestureRecognizer) {
        
        
        let views = (frontView: self.frontView, backView: self.backView)
        let transitionOptons = UIViewAnimationOptions.TransitionFlipFromLeft
        
        UIView.transitionWithView(self.frontView, duration: 1, options: transitionOptons, animations: {
            self.swapView()
            UIView.transitionWithView(self.backView, duration: 1, options: transitionOptons, animations: {
                
                }, completion: { finished in
            })
            }, completion: { finished in
                
        })
        
        
    }
    
    private func swapView(){
        
        if frontView.hidden {
            frontView.hidden = false
            backView.hidden = true
        } else {
            frontView.hidden = true
            backView.hidden = false
        }
        
    }
    

    
    var view:UIView!
    

    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    func xibSetup() {
        if(nil != view) {
            return;
        }
        
        //settings = AppSettings.sharedInstance
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName , bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
}
