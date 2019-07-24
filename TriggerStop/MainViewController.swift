//
//  MainViewController.swift
//  TriggerStop
//
//  Created by T.J. Stone on 5/4/19.
//  Copyright © 2019 T.J. Stone. All rights reserved.
//

import UIKit
import ColorSlider

class MainViewController: UIViewController, UINavigationControllerDelegate {
    
    // Width and height of the view.
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    // Allows user to take a picture or select one from their library
    // if the device does not have a camera.
    var imagePicker: UIImagePickerController!
    
    // Stores all of the emojis on the screen.
    var emojisInView: [EmojiView] = [EmojiView]()
    
    // Tool bar height as a percentage of the view's height.
    let TOOLBAR_HEIGHT: CGFloat = 0.1
    let TOOLBAR_BUTTON_Y: CGFloat = 0.01
    let TOOLBAR_BUTTON_WIDTH: CGFloat = 0.15
    let TOOLBAR_BUTTON_HEIGHT: CGFloat = 0.2
    
    // Amount of space between the toolbar buttons and the right edge of the screen.
    let TOOLBAR_BUTTON_RIGHT_PADDING: CGFloat = 5
    
    // Color of the toolbar.  Uses DEFAULT_COLOR if not set in the interface builder.
    @IBInspectable var toolbarColor: UIColor?
    let TOOLBAR_DEFAULT_COLOR: UIColor = UIColor(hex: 0x126BED)
    
    // Displays application name on the left side of the toolbar.
    var toolbarLabel: UILabel!
    let TOOLBAR_LABEL_TEXT: String = "TriggerStop"
    let TOOLBAR_LABEL_COLOR: UIColor = UIColor.white
    let TOOLBAR_LABEL_X: CGFloat = 0.03
    let TOOLBAR_LABEL_WIDTH: CGFloat = 0.4
    let TOOLBAR_LABEL_FONT_SIZE: CGFloat = 25
    let TOOLBR_LABEL_FONT: String = "Arial"
    
    var clearScreenButton: UIButton!
    var addPhotoButton: UIButton!
    var helpButton: UIButton!
    
    let HELP_BUTTON_Y: CGFloat = 0.11
    let HELP_BUTTON_HEIGHT: CGFloat = 0.002
    
    // Image view for the body.
    var bodyIV :UIImageView!
    
    // Body image coordinates and size as a percentage of view's dimensions.
    let BODY_IMAGE_X :CGFloat = 0.15
    let BODY_IMAGE_Y :CGFloat = 0.24
    let BODY_IMAGE_WIDTH :CGFloat = 0.67
    let BODY_IMAGE_HEIGHT :CGFloat = 0.74
    
    // Image view for the face image displayed over the body's head.
    var faceImageIV :UIImageView!

    // Image views for the face buttons.
    var faceButton1 :UIButton!
    var faceButton2 :UIButton!
    var faceButton3 :UIButton!
    var faceButton4 :UIButton!
    
    /* Face button container coordinates and size as a
       percentage of view's dimensions. */
    let FACE_BUTTON_X :CGFloat = 0.5
    let FACE_BUTTON_Y :CGFloat = 0.11
    let FACE_BUTTON_WIDTH :CGFloat = 0.11
    let FACE_BUTTON_HEIGHT :CGFloat = 0.11
    
    // EmojiViews currently acting as emoji buttons (user has not moved the emoji yet).
    var emojiButton1: EmojiView!
    var emojiButton2: EmojiView!
    var emojiButton3: EmojiView!
    var emojiButton4: EmojiView!
    var emojiButton5: EmojiView!
    
    // Emoji button coordinates and size as a percentage of view's dimensions.
    let EMOJI_BUTTON_X :CGFloat = 0.83
    let EMOJI_BUTTON_Y :CGFloat = 0.3
    let EMOJI_BUTTON_WIDTH: CGFloat = 0.15
    let EMOJI_BUTTON_HEIGHT: CGFloat = 0.07
    
    // Vertical spacing between emoji buttons
    let EMOJI_BUTTON_Y_SPACING :CGFloat = 0.05
    
    // Emoji image coordinates relative to where the user touched the screen.
    let NEW_EMOJI_X: CGFloat = 0.15
    let NEW_EMOJI_Y: CGFloat = 0.01
    
    // Emoji image widght and height as percentage of view's dimensions.
    let NEW_EMOJI_WIDTH :CGFloat = 0.15
    let NEW_EMOJI_HEIGHT :CGFloat = 0.15
    
    // Color slider coordinates and size as a percentage of view's dimensions.
    let COLOR_SLIDER_X :CGFloat = 0.05
    let COLOR_SLIDER_Y :CGFloat = 0.24
    let COLOR_SLIDER_WIDTH :CGFloat = 0.05
    let COLOR_SLIDER_HEIGHT :CGFloat = 0.71
    
    // Body button's that change the body background image.
    var bodyButton1 :UIButton!
    var bodyButton2 :UIButton!
    var bodyButton3 :UIButton!
    var bodyButton4 :UIButton!
    
    var greenFaceImages = [UIImage]()
    var blueFaceImages = [UIImage]()
    var orangeFaceImages = [UIImage]()
    var redFaceImages = [UIImage]()
    
    var greenEmojiImages = [UIImage]()
    var blueEmojiImages = [UIImage]()
    var orangeEmojiImages = [UIImage]()
    var redEmojiImages = [UIImage]()
    
    var bodyImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = view.frame.width
        height = view.frame.height
        
        // Create the body background image view.
        setBodyImage()
        initializeFaceButtons()
        initializeEmojiButtons()
        initializeBodyButtons()
        initializeColorSlider()
        initializeToolBar()
    }
    
    /**
     * Sets the up the tool bar view and tool bar buttons:
     * clear screen, take photo, and help page.
     */
    func initializeToolBar() {
        
        let toolbarView: UIView = UIView(frame:
            CGRect(x: 0.0,
                   y: 0.0,
                   width: width,
                   height: height * TOOLBAR_HEIGHT))
        
        // Use the default color if value is not set in the interface builder.
        if toolbarColor == nil {
            toolbarColor = TOOLBAR_DEFAULT_COLOR
        }
        toolbarView.backgroundColor = toolbarColor
        
        let toolBarButtonY = height * TOOLBAR_BUTTON_Y
        let toolbarButtonWidth = width * TOOLBAR_BUTTON_WIDTH
        let toolbarButtonHeight = height * TOOLBAR_HEIGHT
        
        toolbarLabel = UILabel(
            frame: CGRect(
                x: width * TOOLBAR_LABEL_X,
                y: toolBarButtonY,
                width: width * TOOLBAR_LABEL_WIDTH,
                height: toolbarButtonHeight))
        toolbarLabel.text = TOOLBAR_LABEL_TEXT
        toolbarLabel.textColor = TOOLBAR_LABEL_COLOR
        toolbarLabel.font = UIFont(
            name: TOOLBR_LABEL_FONT,
            size: TOOLBAR_LABEL_FONT_SIZE)
        
        helpButton = UIButton(
            frame: CGRect(
                x: (width - toolbarButtonWidth * 3) - TOOLBAR_BUTTON_RIGHT_PADDING,
                y: toolBarButtonY,
                width: toolbarButtonWidth,
                height: toolbarButtonHeight))
        helpButton.setImage(UIImage(named: "help"), for: .normal)
        helpButton.addTarget(
            self,
            action: Selector(("showHelpPage:")),
            for: .touchUpInside)
        
        clearScreenButton = UIButton(
            frame: CGRect(
                x: (width - toolbarButtonWidth * 2) - TOOLBAR_BUTTON_RIGHT_PADDING,
                y: toolBarButtonY,
                width: toolbarButtonWidth,
                height: toolbarButtonHeight))
        clearScreenButton.setImage(UIImage(named: "trash"), for: .normal)
        clearScreenButton.addTarget(
            self,
            action: Selector(("clearScreen:")),
            for: .touchUpInside)
        
        addPhotoButton = UIButton(
            frame: CGRect(
                x: (width - toolbarButtonWidth) - TOOLBAR_BUTTON_RIGHT_PADDING,
                y: toolBarButtonY,
                width: toolbarButtonWidth,
                height: toolbarButtonHeight))
        addPhotoButton.setImage(UIImage(named: "camera"), for: .normal)
        addPhotoButton.addTarget(
            self,
            action: Selector(("takePhoto:")),
            for: .touchUpInside)

        
        view.addSubview(toolbarView)
        view.addSubview(toolbarLabel)
        toolbarView.addSubview(clearScreenButton)
        toolbarView.addSubview(addPhotoButton)
        toolbarView.addSubview(helpButton)
        
        toolbarView.contentMode = .center
    }
    
    /**
        Sets the background body image and face image.
     */
    func setBodyImage() {
        bodyIV = UIImageView(image: UIImage(named: "BlackBody"))
        bodyIV.frame = CGRect(
            x: width * BODY_IMAGE_X,
            y: height * BODY_IMAGE_Y,
            width: width * BODY_IMAGE_WIDTH,
            height: height * BODY_IMAGE_HEIGHT)
        view.addSubview(bodyIV)
    }
    
    //MARK:- Initialize Face images/buttons.
    
    /**
        Initializes the green, blue, orange, and red lists of face images.
     */
    func loadFaceImages() {
        greenFaceImages.append(UIImage(named: "GreenHappy")!)
        greenFaceImages.append(UIImage(named: "GreenNoMouth")!)
        
        blueFaceImages.append(UIImage(named: "BlueNoMouth")!)
        blueFaceImages.append(UIImage(named: "BlueSad")!)
        blueFaceImages.append(UIImage(named: "BlueSilly")!)
        blueFaceImages.append(UIImage(named: "BlueWorried")!)
        
        orangeFaceImages.append(UIImage(named: "OrangeMad")!)
        orangeFaceImages.append(UIImage(named: "OrangeSad")!)
        orangeFaceImages.append(UIImage(named: "OrangeSilly")!)
        orangeFaceImages.append(UIImage(named: "OrangeWorried")!)
        
        redFaceImages.append(UIImage(named: "RedMad")!)
        redFaceImages.append(UIImage(named: "RedSad")!)
        redFaceImages.append(UIImage(named: "RedWorried")!)
    }
    
    /**
        Creates a container to hold the face image views.
        Initializes each image view with a tap gesture recognizers that calls the
        faceButtonPressed method and adds them to the container.
     */
    func initializeFaceButtons() {
        loadFaceImages()
        
        
        let faceButtonWidth = width * FACE_BUTTON_WIDTH
        let faceButtonHeight = height * FACE_BUTTON_HEIGHT
        let faceButtonY = height * FACE_BUTTON_HEIGHT
        let faceButtonX = width * FACE_BUTTON_X
        let faceBorderWidth :CGFloat = 0.5
        
        faceButton1 = UIButton(frame: CGRect(
            x: faceButtonX,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton1.setImage(greenFaceImages[0], for: .normal)
        faceButton1.contentVerticalAlignment = .fill
        faceButton1.contentHorizontalAlignment = .fill
        faceButton1.layer.borderColor = UIColor.black.cgColor
        faceButton1.layer.borderWidth = faceBorderWidth
        faceButton1.addTarget(self, action: Selector(("faceButtonPressed:")),
                               for: .touchUpInside)
        
        
        faceButton2 = UIButton(frame: CGRect(
            x: faceButtonX + faceButtonWidth,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton2.setImage(greenFaceImages[1], for: .normal)
        faceButton2.contentVerticalAlignment = .fill
        faceButton2.contentHorizontalAlignment = .fill
        faceButton2.layer.borderColor = UIColor.black.cgColor
        faceButton2.layer.borderWidth = faceBorderWidth
        faceButton2.addTarget(self, action: Selector(("faceButtonPressed:")),
                              for: .touchUpInside)
        
        
        faceButton3 = UIButton(frame: CGRect(
            x: faceButtonX + faceButtonWidth * 2,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton3.contentVerticalAlignment = .fill
        faceButton3.contentHorizontalAlignment = .fill
        faceButton3.layer.borderColor = UIColor.black.cgColor
        faceButton3.layer.borderWidth = 0
        faceButton3.addTarget(self, action: Selector(("faceButtonPressed:")),
                              for: .touchUpInside)
        
        faceButton4 = UIButton(frame: CGRect(
            x: faceButtonX + faceButtonWidth * 3,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton4.contentVerticalAlignment = .fill
        faceButton4.contentHorizontalAlignment = .fill
        faceButton4.layer.borderColor = UIColor.black.cgColor
        faceButton4.layer.borderWidth = 0
        faceButton4.addTarget(self, action: Selector(("faceButtonPressed:")),
                              for: .touchUpInside)
        
        view.addSubview(faceButton1)
        view.addSubview(faceButton2)
        view.addSubview(faceButton3)
        view.addSubview(faceButton4)
    }
    
    //MARK:- Initialize emoji images/buttons.
    
    func loadEmojiImages() {
        greenEmojiImages.append(UIImage(named: "GreenEmoji1")!)
        greenEmojiImages.append(UIImage(named: "GreenEmoji2")!)
        greenEmojiImages.append(UIImage(named: "GreenEmoji3")!)
        greenEmojiImages.append(UIImage(named: "GreenEmoji4")!)
        greenEmojiImages.append(UIImage(named: "GreenEmoji5")!)
        
        
        
        blueEmojiImages.append(UIImage(named: "BlueEmoji1")!)
        blueEmojiImages.append(UIImage(named: "BlueEmoji2")!)
        blueEmojiImages.append(UIImage(named: "BlueEmoji3")!)
        blueEmojiImages.append(UIImage(named: "BlueEmoji4")!)
        blueEmojiImages.append(UIImage(named: "BlueEmoji5")!)
        
        
        orangeEmojiImages.append(UIImage(named: "OrangeEmoji1")!)
        orangeEmojiImages.append(UIImage(named: "OrangeEmoji2")!)
        orangeEmojiImages.append(UIImage(named: "OrangeEmoji3")!)
        orangeEmojiImages.append(UIImage(named: "OrangeEmoji4")!)
        orangeEmojiImages.append(UIImage(named: "OrangeEmoji5")!)
        
        redEmojiImages.append(UIImage(named: "RedEmoji1")!)
        redEmojiImages.append(UIImage(named: "RedEmoji2")!)
        redEmojiImages.append(UIImage(named: "RedEmoji3")!)
        redEmojiImages.append(UIImage(named: "RedEmoji4")!)
        redEmojiImages.append(UIImage(named: "RedEmoji5")!)
    }
    
    /**
     Creates a container to hold the emoji buttons.
     Initializes each image view with a tap gesture recognizers that calls the
     emojiButtonPressed method and adds them to the container.
     */
    func initializeEmojiButtons() {
        loadEmojiImages()
        
        let emojiButtonWidth :CGFloat = width * EMOJI_BUTTON_WIDTH
        let emojiButtonHeight :CGFloat = height * EMOJI_BUTTON_HEIGHT
        
        let emojiButtonX :CGFloat = width * EMOJI_BUTTON_X
        let emojiButtonY :CGFloat = height * EMOJI_BUTTON_Y
        let emojiYIncrement :CGFloat = height * EMOJI_BUTTON_Y_SPACING
            + emojiButtonHeight
        
        emojiButton1 = EmojiView(
            frame: CGRect(
                x: emojiButtonX,
                y: emojiButtonY,
                width: emojiButtonWidth,
                height: emojiButtonHeight))
        emojiButton1.image = greenEmojiImages[0]
        emojiButton1.isUserInteractionEnabled = true
        emojiButton1.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
        
        emojiButton2 = EmojiView(
            frame: CGRect(
                x: emojiButtonX,
                y:  emojiButtonY + emojiYIncrement,
                width: emojiButtonWidth,
                height: emojiButtonHeight))
        emojiButton2.image = greenEmojiImages[1]
        emojiButton2.isUserInteractionEnabled = true
        emojiButton2.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
        
        emojiButton3 = EmojiView(
            frame: CGRect(
                x:  emojiButtonX,
                y:  emojiButtonY + emojiYIncrement * 2,
                width: emojiButtonWidth,
                height: emojiButtonHeight))
        emojiButton3.image = greenEmojiImages[2]
        emojiButton3.isUserInteractionEnabled = true
        emojiButton3.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
        
        emojiButton4 = EmojiView(
            frame: CGRect(
                x:  emojiButtonX,
                y:  emojiButtonY + emojiYIncrement * 3,
                width: emojiButtonWidth,
                height: emojiButtonHeight))
        emojiButton4.image = greenEmojiImages[3]
        emojiButton4.isUserInteractionEnabled = true
        emojiButton4.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
        
        emojiButton5 = EmojiView(
            frame: CGRect(
                x:  emojiButtonX,
                y:  emojiButtonY + emojiYIncrement * 4,
                width: emojiButtonWidth,
                height: emojiButtonHeight))
        emojiButton5.image = greenEmojiImages[4]
        emojiButton5.isUserInteractionEnabled = true
        emojiButton5.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
        
        emojisInView.append(emojiButton1)
        emojisInView.append(emojiButton2)
        emojisInView.append(emojiButton3)
        emojisInView.append(emojiButton4)
        emojisInView.append(emojiButton5)

        view.addSubview(emojiButton1)
        view.addSubview(emojiButton2)
        view.addSubview(emojiButton3)
        view.addSubview(emojiButton4)
        view.addSubview(emojiButton5)
    }
    
    
    //MARK:- Face button functionality.
    
    func setFaceImage(image: UIImage?) {
        if image == nil {return}
        
        if faceImageIV == nil {
            faceImageIV = UIImageView(
                frame: CGRect(x: width * 0.325,
                              y: height * 0.24,
                              width: width * 0.32,
                              height: height * 0.22))
            view.addSubview(faceImageIV)
            view.sendSubviewToBack(faceImageIV)
            view.sendSubviewToBack(bodyIV)
        }
        
        DispatchQueue.main.async {
            self.faceImageIV.image = image
        }
    }
    
    /**
        Called when a face button is pressed.
     
        Creates and image view and sets it's image to the selected
        face. The image view is presented over the body's head.
    */
    @objc func faceButtonPressed(_ sender: UIButton) {
        let selectedFaceIV :UIImageView? = sender.imageView
        
        if selectedFaceIV == nil {
            return
        }
        
        DispatchQueue.main.async {
            self.setFaceImage(image: selectedFaceIV?.image)
        }
    }
    
    func loadBodyImages() {
        bodyImages.append(UIImage(named: "WhiteBody")!)
        bodyImages.append(UIImage(named: "YellowBody")!)
        bodyImages.append(UIImage(named: "BrownBody")!)
        bodyImages.append(UIImage(named: "BlackBody")!)
    }
    
    //MARK: Initialize body buttons.
    
    /**
     Creates a container to hold the body buttons image views.
     Initializes each image view with a tap gesture recognizers that calls the
     faceButtonPressed method and adds them to the container.
     */
    func initializeBodyButtons() {
        loadBodyImages()
        
        let bodyButtonWidth = width * 0.11
        let bodyButtonHeight = height * 0.11
        let bodyButtonX = width * 0.02
        let bodyButtonY = height * 0.11
        let bodyBorderWidth :CGFloat = 0.5
        
        bodyButton1 = UIButton(frame: CGRect(
            x: bodyButtonX,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton1.setImage(bodyImages[0], for: .normal)
        bodyButton1.layer.borderColor = UIColor.black.cgColor
        bodyButton1.layer.borderWidth = bodyBorderWidth
        bodyButton1.addTarget(self, action: Selector(("bodyButtonPressed:")),
                               for: .touchUpInside)
        view.addSubview(bodyButton1)

        bodyButton2 = UIButton(frame: CGRect(
            x: bodyButtonX + bodyButtonWidth,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton2.setImage(bodyImages[1], for: .normal)
        bodyButton2.layer.borderColor = UIColor.black.cgColor
        bodyButton2.layer.borderWidth = bodyBorderWidth
        bodyButton2.addTarget(self, action: Selector(("bodyButtonPressed:")),
                              for: .touchUpInside)
        view.addSubview(bodyButton2)
        
        bodyButton3 = UIButton(frame: CGRect(
            x: bodyButtonX + bodyButtonWidth * 2,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton3.setImage(bodyImages[2], for: .normal)
        bodyButton3.layer.borderColor = UIColor.black.cgColor
        bodyButton3.layer.borderWidth = bodyBorderWidth
        bodyButton3.addTarget(self, action: Selector(("bodyButtonPressed:")),
                              for: .touchUpInside)
        view.addSubview(bodyButton3)
        
        bodyButton4 = UIButton(frame: CGRect(
            x: bodyButtonX + bodyButtonWidth * 3,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton4.setImage(bodyImages[3], for: .normal)
        bodyButton4.layer.borderColor = UIColor.black.cgColor
        bodyButton4.layer.borderWidth = bodyBorderWidth
        bodyButton4.addTarget(self, action: Selector(("bodyButtonPressed:")),
                              for: .touchUpInside)
        view.addSubview(bodyButton4)
    }
    
    
    //MARK: Body Button functionality.
    
    
    /**
     Called when a body button is pressed.
     
     Sets the body image to the selected button's image.
     */
    @objc func bodyButtonPressed(_ sender: UIButton) {
        
        let selectedBodyIV :UIImageView? = sender.imageView
        if selectedBodyIV == nil {
            return
        }
        
        DispatchQueue.main.async {
            self.bodyIV.image = selectedBodyIV?.image
        }
    }
    
    /**
        Clears the face image and emoji images on the screen.
    */
    @IBAction func clearScreen(_ sender: Any) {
        var i: Int = emojisInView.count - 1
        while i >= 0  {
            let emoji: EmojiView = emojisInView[i]
            if emoji.hasBeenTouched.value {
                emoji.removeFromSuperview()
                emojisInView.remove(at: i)
            }
            
            i -= 1
        }
        
        if faceImageIV != nil {
            faceImageIV.image = nil
        }
    }
    
    /**
     * Called when the user clicks the help button.
     * Displays the help page over the current view.
     */
    @IBAction func showHelpPage(_ sender: Any) {
        let popOverVC: PopUpViewController = UIStoryboard(
            name: "Main", bundle: nil).instantiateViewController(
                withIdentifier: "helpPage") as! PopUpViewController

        popOverVC.view.frame = view.frame
        
        
        self.addChild(popOverVC)
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    
    //MARK: - Color Slider
    
    /**
     Sets up the color slider and adds it to the view.
     */
    func initializeColorSlider() {
        // Set up the color slider.
        let colorSlider = ColorSlider(
            orientation: .vertical,
            previewSide: .right)
        
        colorSlider.frame = CGRect(
            x: width * COLOR_SLIDER_X,
            y: height * COLOR_SLIDER_Y,
            width: width * COLOR_SLIDER_WIDTH,
            height: height * COLOR_SLIDER_HEIGHT)
        
        // Set callback function for when the color slider's value changes.
        colorSlider.addTarget(
            self,
            action: #selector(changedColor(_:)),
            for: .valueChanged)
        
        view.addSubview(colorSlider)
    }
    
    @objc func changedColor(_ slider: ColorSlider) {
        let percentage: CGFloat = slider.currentPercentage * 100
        
        var newFaceImages :[UIImage]
        var newEmojiImages :[UIImage]
        
        if percentage <= 25 {
            newFaceImages = self.greenFaceImages
            newEmojiImages = self.greenEmojiImages
        }
        else if percentage <= 50 {
            newFaceImages = self.blueFaceImages
            newEmojiImages = self.blueEmojiImages
        }
        else if percentage <= 75 {
            newFaceImages = self.orangeFaceImages
            newEmojiImages = self.orangeEmojiImages
        }
        else {
            newFaceImages = self.redFaceImages
            newEmojiImages = self.redEmojiImages
        }
        
        DispatchQueue.main.async {
            // TODO: Make this nicer.
            self.emojiButton1.image = newEmojiImages[0]
            self.emojiButton2.image = newEmojiImages[1]
            self.emojiButton3.image = newEmojiImages[2]
            self.emojiButton4.image = newEmojiImages[3]
            self.emojiButton5.image = newEmojiImages[4]
            
            self.faceButton1.setImage(newFaceImages[0], for: .normal)
            self.faceButton2.setImage(newFaceImages[1], for: .normal)
            
            if newFaceImages.count >= 3 {
                self.faceButton3.setImage(newFaceImages[2], for: .normal)
                self.faceButton3.layer.borderWidth = 0.5
            }
            else {
                self.faceButton3.setImage(nil, for: .normal)
                self.faceButton3.layer.borderWidth = 0
            }
            
            if newFaceImages.count == 4 {
                self.faceButton4.setImage(newFaceImages[3], for: .normal)
                self.faceButton4.layer.borderWidth = 0.5
            }
            else {
                self.faceButton4.setImage(nil, for: .normal)
                self.faceButton4.layer.borderWidth = 0
            }
        }
    }
    
    //MARK: Emoji Button functionality.
    
    @objc func emojiButtonPressed(_ sender: UIButton) {
        
        let touchLocationInView = sender.frame.origin
        let selectedEmojiIV :UIImageView? = sender.imageView
        
        if selectedEmojiIV?.image == nil {
            return
        }
        
        let emojiView = EmojiView(image: selectedEmojiIV?.image)
        emojiView.frame = CGRect(
            x: touchLocationInView.x - width * NEW_EMOJI_X,
            y: touchLocationInView.y - height * NEW_EMOJI_Y,
            width: self.view.bounds.width * NEW_EMOJI_WIDTH,
            height: self.view.bounds.width * NEW_EMOJI_HEIGHT)
        
        emojiView.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action:Selector(("moveEmoji:")))
        
        emojiView.addGestureRecognizer(panGesture)
        self.emojisInView.append(emojiView)
        
        DispatchQueue.main.async {
            print("Emojies in view: \(self.emojisInView.count)")
            self.view.addSubview(emojiView)
        }
    }
    
    
    // The initial location of the emoji being moved by the user.
    var emojiInitialCenter = CGPoint()
    
    /***
     Moves the selected emoji ImageView around the screen.
     
     - Parameter sender: The touch event caused by the user touching the screen.
    */
    @objc func moveEmoji(_ sender: UIPanGestureRecognizer) {
        guard sender.view != nil else {return}
        
        let emojiView: EmojiView = sender.view! as! EmojiView
        
        // Emoji is on the right side of the screen in the emoji button column.
        if !emojiView.hasBeenTouched.value {
            
            emojiView.hasBeenTouched.mutate({$0 = true})
            
            // Add a replacement EmojiView in the emoji button column.
            let newEmojiFrame: CGRect = emojiView.frame
            let newEmoji: EmojiView = EmojiView(frame: newEmojiFrame)
            
            newEmoji.image = emojiView.image
            newEmoji.isUserInteractionEnabled = true
            newEmoji.addGestureRecognizer(UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
            
            self.view.addSubview(newEmoji)
            DispatchQueue.main.async {
                if emojiView == self.emojiButton1 {
                    self.emojiButton1 = newEmoji
                }
                else if emojiView == self.emojiButton2 {
                    self.emojiButton2 = newEmoji
                }
                else if emojiView == self.emojiButton3 {
                    self.emojiButton3 = newEmoji
                }
                else if emojiView == self.emojiButton4 {
                    self.emojiButton4 = newEmoji
                }
                else if emojiView == self.emojiButton5 {
                    self.emojiButton5 = newEmoji
                }
                self.emojisInView.append(newEmoji)
                newEmoji.hasBeenTouched.mutate({ $0 = false })
            }
        }

        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = sender.translation(in: emojiView.superview)
        
        if sender.state == .began {
            // Save the view's original position.
            self.emojiInitialCenter = emojiView.center
        }
        if sender.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(
                x: emojiInitialCenter.x + translation.x,
                y: emojiInitialCenter.y + translation.y)
            emojiView.center = newCenter
        }
        else {
            // On cancellation, return the piece to its original location.
            emojiView.center = emojiInitialCenter
        }
    }
    
    //MARK: Camera/Photo Library functionality.
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    //MARK: - Take image
    @IBAction func takePhoto(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Save image.
    @IBAction func save(_ sender: AnyObject) {
        guard let selectedImage = faceImageIV.image else {
            print("Image not found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage,
                     didFinishSavingWithError error: Error?,
                     contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlertWith(
                title: "Save error",
                message: error.localizedDescription)
        } else {
            showAlertWith(
                title: "Saved!",
                message: "Your image has been saved to your photos.")
        }
    }
    
    func showAlertWith(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

extension MainViewController: UIImagePickerControllerDelegate {
    
    //MARK: Get the selected picture from camera or library.
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        setFaceImage(image: selectedImage)
    }
}
