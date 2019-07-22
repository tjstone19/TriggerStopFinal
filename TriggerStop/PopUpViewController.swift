//
//  PopUpViewController.swift
//  TriggerStop
//
//  Created by T.J. Stone on 7/21/19.
//  Copyright © 2019 T.J. Stone. All rights reserved.
//

import Foundation
import UIKit

class PopUpViewController: UIViewController {
    var width: CGFloat!
    var height: CGFloat!
    
    // Displays the help page text.
    var textView: UITextView!
    
    // Enables the user to scroll throught the help page text.
    var scrollView: UIScrollView!
    
    var closeButton: UIButton!
    
    // Text/Scroll view's dimensions as a percentage of the view's width and height.
    let TEXT_VIEW_X: CGFloat = 0.05
    let TEXT_VIEW_Y: CGFloat = 0.02
    let TEXT_VIEW_WIDTH: CGFloat = 0.85
    let TEXT_VIEW_HEIGHT: CGFloat = 0.83
    
    let TEXT_VIEW_FONT: String = "Arial"
    let TEXT_VIEW_FONT_SIZE: CGFloat = 14
    
    let SCROLL_VIEW_X: CGFloat = 0.02
    let SCROLL_VIEW_HEIGHT: CGFloat = 0.85
    let SCROLL_VIEW_WIDTH: CGFloat = 0.93
    
    // Close button's dimensions as a percentage of the view's width and height.
    let CLOSE_BUTTON_X: CGFloat = 0.4
    let CLOSE_BUTTON_Y: CGFloat = 0.85
    let CLOSE_BUTTON_WIDTH: CGFloat = 0.2
    let CLOSE_BUTTON_HEIGHT: CGFloat = 0.15
    
    let CLOSE_BUTTON_FONT_SIZE: CGFloat = 25
    
    /* The text to be displayed in the help page.
     Text to be displayed  is set in the interface builder. */
    @IBInspectable var helpText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        width = view.frame.width
        height = view.frame.height
        
        // Initialize scroll view and text view.
        scrollView = UIScrollView(frame: CGRect(
            x: width * SCROLL_VIEW_X,
            y: height * TEXT_VIEW_Y,
            width: width * SCROLL_VIEW_WIDTH,
            height: height * SCROLL_VIEW_HEIGHT))

        textView = UITextView(frame: CGRect(
            x: width * TEXT_VIEW_X,
            y: height * TEXT_VIEW_Y,
            width: width * TEXT_VIEW_WIDTH,
            height: height * TEXT_VIEW_HEIGHT))
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.textAlignment = .justified
        textView.font = UIFont(name: TEXT_VIEW_FONT, size: TEXT_VIEW_FONT_SIZE)
        
        // Set the help page text to the text set in the interface builder.
        textView.text = helpText
        
        // Initialize the close button to call closePopUp on click.
        closeButton = UIButton(frame: CGRect(
            x: width * CLOSE_BUTTON_X,
            y: height * CLOSE_BUTTON_Y,
            width: width * CLOSE_BUTTON_WIDTH,
            height: height * CLOSE_BUTTON_HEIGHT))
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.titleLabel?.textColor = UIColor.blue
        closeButton.titleLabel?.font = UIFont.boldSystemFont(
            ofSize: CLOSE_BUTTON_FONT_SIZE)
        
        closeButton.addTarget(self,
                              action: #selector(closePopUp(_:)),
                              for: .touchUpInside)

        scrollView.addSubview(textView)
        view.addSubview(scrollView)
        view.addSubview(closeButton)
    }
    
    @objc func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}
