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
    
    // Text/Scroll view's dimensions as a percentage of the view's width and height.
    let TEXT_VIEW_X: CGFloat = 0.05
    let TEXT_VIEW_Y: CGFloat = 0.02
    let TEXT_VIEW_WIDTH: CGFloat = 0.85
    let TEXT_VIEW_HEIGHT_HELP_PAGE: CGFloat = 0.83
    let TEXT_VIEW_HEIGHT_DISCLAIMER_PAGE: CGFloat = 0.6
    
    let TEXT_VIEW_FONT: String = "Arial"
    let TEXT_VIEW_FONT_SIZE: CGFloat = 14
    let TEXT_VIEW_SIDE_INSET: CGFloat = 2.0
    
    let SCROLL_VIEW_X: CGFloat = 0.02
    let SCROLL_VIEW_HEIGHT: CGFloat = 0.85
    let SCROLL_VIEW_WIDTH: CGFloat = 0.93
    
    // Button that closes the help page.
    var closeButton: UIButton!
    
    // Close button's dimensions as a percentage of the view's width and height.
    let CLOSE_BUTTON_X: CGFloat = 0.4
    let CLOSE_BUTTON_Y: CGFloat = 0.85
    let CLOSE_BUTTON_WIDTH: CGFloat = 0.2
    let CLOSE_BUTTON_HEIGHT: CGFloat = 0.15
    let CLOSE_BUTTON_FONT_SIZE: CGFloat = 25
    
    /* Enabled when the user accepts the TOS.  Removes the view from the
       super view when pressed. */
    var continueButton: UIButton!
    
    let CONTINUE_BUTTON_X: CGFloat = 0.2
    let CONTINUE_BUTTON_Y: CGFloat = 0.85
    let CONTINUE_BUTTON_WIDTH: CGFloat = 0.3
    let CONTINUE_BUTTON_HEIGHT: CGFloat = 0.15
    let DISCLAIMER_BUTTON_SPACING: CGFloat = 0.05
    
    // Dimensions for label telling users they need to accept TOS before using the app.
    let ACCEPT_TERMS_LABEL_X: CGFloat = 0.1
    let ACCEPT_TERMS_LABEL_Y: CGFloat = 0.65
    let ACCEPT_TERMS_LABEL_WIDTH: CGFloat = 0.8
    let ACCEPT_TERMS_LABEL_HEIGHT: CGFloat = 0.1
    let ACCEPT_TERMS_LABEL_TEXT: String = "You must accept the terms of service before using the app."
    
    
    // Dimensions for label telling users to select the box to accept TOS.
    let CHECK_BOX_LABEL_X: CGFloat = 0.25
    let CHECK_BOX_LABEL_Y: CGFloat = 0.76
    let CHECK_BOX_LABEL_WIDTH: CGFloat = 0.7
    let CHECK_BOX_LABEL_HEIGHT: CGFloat = 0.1
    let CHECK_BOX_LABEL_TEXT: String = "Accept the Terms of Service."
    
    // Button that accepts the TOS.
    var checkBoxButton: UIButton!

    // Images for the selected/unselected check box button.
    let checkBoxSelectedImage: UIImage = UIImage(named: "CheckBoxSelected")!
    let checkBoxUnselectedImage: UIImage = UIImage(named: "CheckBoxUnselected")!
    
    // Dimensions for check box button that accepts the TOS.
    let CHECK_BOX_BUTTON_X: CGFloat = 0.1
    let CHECK_BOX_BUTTON_Y: CGFloat = 0.71
    let CHECK_BOX_BUTTON_WIDTH: CGFloat = 0.15
    let CHECK_BOX_BUTTON_HEIGHT: CGFloat = 0.2
    
    
    // Help screen text set in the interface builder.
    @IBInspectable var helpText: String?
    
    // Disclaimer screen text set in the interface builder.
    @IBInspectable var disclaimerText: String?
    
    // If true, display help page text.  If false, display disclaimer text.
    var isHelpPage: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        width = view.frame.width
        height = view.frame.height
        
        // Set up the text view and scroll view.
        initializeTextView()
        
        // Set the help page text to the text set in the interface builder.
        if isHelpPage {
            initializeHelpView()
        }
        else {
            initializeDisclaimerView()
        }
    }
    
    /**
     * Initializes the text view and scroll view.
     */
    private func initializeTextView() {
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
            height: height * TEXT_VIEW_HEIGHT_HELP_PAGE))
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.textAlignment = .justified
        textView.contentInset.left = TEXT_VIEW_SIDE_INSET
        textView.contentInset.right = TEXT_VIEW_SIDE_INSET
        textView.font = UIFont(name: TEXT_VIEW_FONT, size: TEXT_VIEW_FONT_SIZE)
        
        scrollView.addSubview(textView)
        view.addSubview(scrollView)
    }
    
    /**
     * Sets the text to the disclaimer page text and initializes
     * Accept and Decline button.
     */
    func initializeDisclaimerView() {
        textView.text = disclaimerText
        textView.frame = CGRect(
            x: width * TEXT_VIEW_X,
            y: height * TEXT_VIEW_Y,
            width: width * TEXT_VIEW_WIDTH,
            height: height * TEXT_VIEW_HEIGHT_DISCLAIMER_PAGE)
        
        // Add label notifying user that they must accept the TOS before using the app.
        let acceptLabelX: CGFloat = width * ACCEPT_TERMS_LABEL_X
        let acceptLabelY: CGFloat =  height * ACCEPT_TERMS_LABEL_Y
        let acceptLabelWidth: CGFloat = width * ACCEPT_TERMS_LABEL_WIDTH
        let acceptLabelHeight: CGFloat = ACCEPT_TERMS_LABEL_HEIGHT * height
        
        let acceptTermsLabel :UILabel! = UILabel(frame:
            CGRect(x: acceptLabelX,
                   y: acceptLabelY,
                   width: acceptLabelWidth,
                   height: acceptLabelHeight))
        acceptTermsLabel.text = ACCEPT_TERMS_LABEL_TEXT
        acceptTermsLabel.textColor = .white
        acceptTermsLabel.contentMode = .center
        acceptTermsLabel.numberOfLines = 2
        view.addSubview(acceptTermsLabel)
        
        // Add button for user to accept the TOS.
        let checkBoxX :CGFloat = width * CHECK_BOX_BUTTON_X
        let checkBoxY :CGFloat = height * CHECK_BOX_BUTTON_Y
        let checkBoxWidth :CGFloat = width * CHECK_BOX_BUTTON_WIDTH
        let checkBoxHeight :CGFloat = height * CHECK_BOX_BUTTON_HEIGHT
        
        checkBoxButton = UIButton(frame:
            CGRect(x: checkBoxX,
                   y: checkBoxY,
                   width: checkBoxWidth,
                   height: checkBoxHeight))
        checkBoxButton.setImage(checkBoxUnselectedImage, for: .normal)
        checkBoxButton.addTarget(
            self,
            action: #selector(termsAccepted(_:)),
            for: .touchUpInside)
        
        view.addSubview(checkBoxButton)
        
        // Add label next to box instructing user to accept TOS.
        let checkBoxLabelX: CGFloat = width * CHECK_BOX_LABEL_X
        let checkBoxLabelY: CGFloat = height * CHECK_BOX_LABEL_Y
        let checkBoxLabelWidth: CGFloat = width * CHECK_BOX_LABEL_WIDTH
        let checkBoxLabelHeight: CGFloat = height * CHECK_BOX_LABEL_HEIGHT
        
        let checkBoxLabel :UILabel! = UILabel(frame:
            CGRect(x: checkBoxLabelX,
                   y: checkBoxLabelY,
                   width: checkBoxLabelWidth,
                   height: checkBoxLabelHeight))
        checkBoxLabel.font = UIFont(name: "Arial", size: 20.0)
        checkBoxLabel.adjustsFontSizeToFitWidth = true
        checkBoxLabel.text = CHECK_BOX_LABEL_TEXT
        checkBoxLabel.textColor = .white
        checkBoxLabel.contentMode = .center
        checkBoxLabel.numberOfLines = 2
        view.addSubview(checkBoxLabel)
        
        // Add continue button that removes the pop up view from the superview.
        let continueButtonY: CGFloat = height * CONTINUE_BUTTON_Y
        let continueButtonWidth: CGFloat = width * CONTINUE_BUTTON_WIDTH
        let continueButtonHeight: CGFloat = height * CONTINUE_BUTTON_HEIGHT
        
        continueButton = UIButton(frame: CGRect(
            x: width * 0.5 - continueButtonWidth * 0.5,
            y: continueButtonY,
            width: continueButtonWidth,
            height: continueButtonHeight))
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.textColor = UIColor.blue
        continueButton.titleLabel?.font = UIFont.boldSystemFont(
            ofSize: CLOSE_BUTTON_FONT_SIZE)
        continueButton.addTarget(
            self,
            action: #selector(continueButtonPressed(_:)),
            for: .touchUpInside)
        
        // Disable the continue button until the user accepts the TOS.
        continueButton.isEnabled = false
        continueButton.isHidden = true
        
        view.addSubview(continueButton)
    }
    
    /**
     * Sets the text to the help page text and initializes the close button.
     */
    func initializeHelpView() {
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
        view.addSubview(closeButton)
    }
    
    
    /**
     *  Removes this view from the super view.
     */
    @objc func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    /**
     * Called when the user accepts the disclaimer and presses the
     * continue button.  Sets first launch user defaults variable to false
     * and removes this view from the view hierarchy.
     */
    @objc func continueButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            UserDefaults.setFirstLaunch(false)
        }
        
        self.view.removeFromSuperview()
    }
    
    /**
     * Called when the user declines the disclaimer.  Sets first launch
     * user defaults variable to true and terminates the app.
     */
    @objc func declineDisclaimer(_ sender: Any) {
        // TODO
        self.view.removeFromSuperview()
    }
    
    /**
     * Called when the user touches the check box button.
     *
     * Toggles the continue button's isEnabled and isHidden properties,
     * and updates the check box button's image each time the button is touched.
     */
    @objc func termsAccepted(_ sender: Any) {
        DispatchQueue.main.async {
            self.continueButton.isEnabled = !self.continueButton.isEnabled
            self.continueButton.isHidden = !self.continueButton.isHidden
            
            if self.continueButton.isEnabled {
                self.checkBoxButton.setImage(
                    self.checkBoxSelectedImage, for: .normal)
            }
            else {
                self.checkBoxButton.setImage(
                    self.checkBoxUnselectedImage, for: .normal)
            }
        }
    }
}
