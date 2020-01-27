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
    
    let BODY_IMAGE_X: CGFloat = 0.98
    let BODY_IMAGE_BOTTOM: CGFloat = 0.98
    let BODY_IMAGE_WIDTH: CGFloat = 0.62
    let BODY_IMAGE_HEIGHT :CGFloat = 0.74
    
    // Body image's width as a percentage of the view's height.
    let BODY_IMAGE_WIDTH_TO_HEIGHT_RATIO :CGFloat = 0.33
    
    // Body button dimensions as a percentage of the view's width and height.
    let BODY_BUTTON_X :CGFloat = 0.02
    let BODY_BUTTON_Y :CGFloat = 0.11
    let BODY_BUTTON_WIDTH :CGFloat = 0.11
    let BODY_BUTTON_HEIGHT :CGFloat = 0.11
    
    // Border width for selected/unselected body buttons.
    let BODY_BUTTON_DEFAULT_BORDER_WIDTH :CGFloat = 0.5
    let BODY_BUTTON_SELECTED_BORDER_WIDTH :CGFloat = 2.0
    
    // Border color for selected/unselected body buttons.
    let BODY_BUTTON_DEFAULT_BORDER_COLOR :CGColor = UIColor.black.cgColor
    let BODY_BUTTON_SELECTED_BORDER_COLOR :CGColor = UIColor.red.cgColor
    
    // Body button's that change the body background image.
    var bodyButton1 :UIButton!
    var bodyButton2 :UIButton!
    var bodyButton3 :UIButton!
    var bodyButton4 :UIButton!
    
    // Pointer to the currently selected body button.
    var selectedBodyButton :UIButton!
    
    // Image view for the face image displayed over the body's head.
    var faceImageIV: CircleImageView!
    
    // Face image width as a percentage of the view's height.
    let FACE_IMAGE_WIDTH_TO_HEIGHT_RATIO: CGFloat = 0.3
    
    // The face image is cropped to fit in a frame of this width and height.
    let FACE_IMAGE_CROP_SIZE: CGFloat = 0.25

    /* Face image is removed from the view if it is placed beyond
     the max x or below the min y. */
    let FACE_IMAGE_MAX_X: CGFloat = 0.75
    let FACE_IMAGE_MIN_Y: CGFloat = 0.25
    
    // The initial location of the face image view being moved by the user.
    var faceInitialCenter = CGPoint()

    // Image views for the face buttons.
    var faceButton1 :UIImageView!
    var faceButton2 :UIImageView!
    var faceButton3 :UIImageView!
    var faceButton4 :UIImageView!
    
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
    
    // Emojis are removed from the view if they are placed beyond the max x.
    let EMOJI_VIEW_MAX_X: CGFloat = 0.75
    
    // The initial location of the emoji being moved by the user.
    var emojiInitialCenter = CGPoint()
    
    // Color slider coordinates and size as a percentage of view's dimensions.
    let COLOR_SLIDER_X :CGFloat = 0.05
    let COLOR_SLIDER_Y :CGFloat = 0.24
    let COLOR_SLIDER_WIDTH :CGFloat = 0.05
    let COLOR_SLIDER_HEIGHT :CGFloat = 0.71
    
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
    }
    
    override func loadView() {
        super.loadView()
        
        width = view.frame.width
        height = view.frame.height
        
        // Create the body background image view.
        setBodyImage()
        initializeFaceButtons()
        initializeEmojiButtons()
        initializeBodyButtons()
        initializeColorSlider()
        initializeToolBar()
        
        checkFirstLaunch()
    }
    
    /**
     * Launches the disclaimer page if it is the first launch of the application.
     */
    private func checkFirstLaunch() {
        let isFirstLaunch = UserDefaults.isFirstLaunch()
        
        if isFirstLaunch {
            DispatchQueue.main.async {
                weak var popOverVC: PopUpViewController? = UIStoryboard(
                    name: "Main", bundle: nil).instantiateViewController(
                        withIdentifier: "popUpView") as? PopUpViewController
                
                popOverVC!.view.frame = self.view.frame
                
                self.addChild(popOverVC!)
                self.view.addSubview(popOverVC!.view)
                popOverVC!.didMove(toParent: self)
            }
        }
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

        helpButton.setImage(UIImage(named: "Info"), for: .normal)
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
        bodyIV = UIImageView(image: UIImage(named: "BodyBlack"))
        bodyIV.contentMode = .scaleToFill
        bodyIV.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(bodyIV)

        let x = NSLayoutConstraint(
            item: bodyIV!, attribute: .centerX, relatedBy: .equal, toItem: view,
            attribute: .centerX, multiplier: BODY_IMAGE_X, constant: 0)

        let bottom = NSLayoutConstraint(
            item: bodyIV!, attribute: .bottom, relatedBy: .equal, toItem: view,
            attribute: .bottom, multiplier: BODY_IMAGE_BOTTOM, constant: 0)
        
        let widthAnchor = bodyIV.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: BODY_IMAGE_WIDTH)
        
        let heightAnchor = bodyIV.heightAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: view.frame.height / view.frame.width * BODY_IMAGE_HEIGHT)
        
        NSLayoutConstraint.activate([x, bottom, widthAnchor, heightAnchor])
    }
    
    //MARK:- Initialize Face images/buttons.
    
    /**
        Initializes the green, blue, orange, and red lists of face images.
     */
    func loadFaceImages() {
        greenFaceImages.append(UIImage(named: "GreenFace1")!)
        greenFaceImages.append(UIImage(named: "GreenFace2")!)
        
        blueFaceImages.append(UIImage(named: "BlueFace1")!)
        blueFaceImages.append(UIImage(named: "BlueFace2")!)
        blueFaceImages.append(UIImage(named: "BlueFace3")!)
        blueFaceImages.append(UIImage(named: "BlueFace4")!)
        
        orangeFaceImages.append(UIImage(named: "OrangeFace1")!)
        orangeFaceImages.append(UIImage(named: "OrangeFace2")!)
        orangeFaceImages.append(UIImage(named: "OrangeFace3")!)
        orangeFaceImages.append(UIImage(named: "OrangeFace4")!)
        
        redFaceImages.append(UIImage(named: "RedFace1")!)
        redFaceImages.append(UIImage(named: "RedFace2")!)
        redFaceImages.append(UIImage(named: "RedFace3")!)
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
        
        faceButton1 = UIImageView(frame: CGRect(
            x: faceButtonX,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton1.image = greenFaceImages[0]
        faceButton1.contentMode = .scaleToFill
        faceButton1.layer.borderColor = UIColor.black.cgColor
        faceButton1.layer.borderWidth = faceBorderWidth
        faceButton1.isUserInteractionEnabled = true
        faceButton1.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveFaceOnScreen:"))))
        
        
        faceButton2 = UIImageView(frame: CGRect(
            x: faceButtonX + faceButtonWidth,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton2.image = greenFaceImages[1]
        faceButton2.contentMode = .scaleToFill
        faceButton2.layer.borderColor = UIColor.black.cgColor
        faceButton2.layer.borderWidth = faceBorderWidth
        faceButton2.isUserInteractionEnabled = true
        faceButton2.addGestureRecognizer(UIPanGestureRecognizer(
            target: self,
            action:Selector(("moveFaceOnScreen:"))))
        
        
        faceButton3 = UIImageView(frame: CGRect(
            x: faceButtonX + faceButtonWidth * 2,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton3.contentMode = .scaleToFill
        faceButton3.layer.borderColor = UIColor.black.cgColor
        faceButton3.layer.borderWidth = 0
        faceButton3.isUserInteractionEnabled = true
        faceButton3.addGestureRecognizer(UIPanGestureRecognizer(
            target: self,
            action:Selector(("moveFaceOnScreen:"))))
        
        faceButton4 = UIImageView(frame: CGRect(
            x: faceButtonX + faceButtonWidth * 3,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton4.contentMode = .scaleToFill
        faceButton4.layer.borderColor = UIColor.black.cgColor
        faceButton4.layer.borderWidth = 0
        faceButton4.isUserInteractionEnabled = true
        faceButton4.addGestureRecognizer(UIPanGestureRecognizer(
            target: self,
            action:Selector(("moveFaceOnScreen:"))))
        
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
        emojiButton1.contentMode = .scaleAspectFit
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
        emojiButton2.contentMode = .scaleAspectFit
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
        emojiButton3.contentMode = .scaleAspectFit
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
        emojiButton4.contentMode = .scaleAspectFit
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
        emojiButton5.contentMode = .scaleAspectFit
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
    
    /**
      Sets the face image to the provided UIImage.
     
     - Parameter image: The image to display in the face image view.
     */
    func setFaceImage(image: UIImage?) {
        if image == nil {return}
        
        if faceImageIV == nil {
            faceImageIV = CircleImageView()
            faceImageIV.layer.masksToBounds = true
            faceImageIV.clipsToBounds = true
            faceImageIV.translatesAutoresizingMaskIntoConstraints = false
            faceImageIV!.isUserInteractionEnabled = true
            
            // Add gesture recognizer to move face around the screen.
            let panGesture = UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveFaceOffScreen:")))
            faceImageIV!.addGestureRecognizer(panGesture)
            
            view.addSubview(faceImageIV)

            // Add layout constrains to determine size and position of the face.
            let x = NSLayoutConstraint(
                item: faceImageIV!, attribute: .centerX, relatedBy: .equal,
                toItem: bodyIV, attribute: .centerX, multiplier: 1.0,
                constant: 0)
            
            let top = NSLayoutConstraint(
                item: faceImageIV!, attribute: .top, relatedBy: .equal,
                toItem: bodyIV, attribute: .top, multiplier: 1.0, constant: -1)
            
            let widthAnchor = faceImageIV.widthAnchor.constraint(
                equalTo: bodyIV.widthAnchor,
                multiplier: bodyIV.frame.height / bodyIV.frame.width * FACE_IMAGE_WIDTH_TO_HEIGHT_RATIO)

            let heightAnchor = faceImageIV.heightAnchor.constraint(
                equalTo: bodyIV.widthAnchor,
                multiplier: bodyIV.frame.height / bodyIV.frame.width * FACE_IMAGE_WIDTH_TO_HEIGHT_RATIO)
            
            NSLayoutConstraint.activate([widthAnchor, heightAnchor, x, top])
            
            faceImageIV.horizontalConstraint = x
            faceImageIV.verticalConstraint = top
            
            view.sendSubviewToBack(faceImageIV)
            view.sendSubviewToBack(bodyIV)
        }
        
        // Crop the image to be a square before putting it in a circular frame.
        // If the photo is not a square than the face image will appear as an oval.
        let croppedFaceImageSize = faceImageIV.frame.height
        let croppedImage = image?.cropToBounds(
            width: croppedFaceImageSize,
            height: croppedFaceImageSize)
        
        DispatchQueue.main.async {
            self.faceImageIV.image = croppedImage
        }
    }
    
    /**
        Called when a face button is pressed.
     
        Creates an image view and sets it's image to the selected
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
        bodyImages.append(UIImage(named: "BodyWhite")!)
        bodyImages.append(UIImage(named: "BodyYellow")!)
        bodyImages.append(UIImage(named: "BodyBrown")!)
        bodyImages.append(UIImage(named: "BodyBlack")!)
    }
    
    //MARK: Initialize body buttons.
    
    /**
     Creates a container to hold the body buttons image views.
     Initializes each image view with a tap gesture recognizers that calls the
     faceButtonPressed method and adds them to the container.
     */
    func initializeBodyButtons() {
        loadBodyImages()
        
        let bodyButtonWidth = width * BODY_BUTTON_WIDTH
        let bodyButtonHeight = height * BODY_BUTTON_HEIGHT
        let bodyButtonX = width * BODY_BUTTON_X
        let bodyButtonY = height * BODY_BUTTON_Y
        
        bodyButton1 = UIButton(frame: CGRect(
            x: bodyButtonX,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton1.setImage(bodyImages[0], for: .normal)
        bodyButton1.layer.borderColor = BODY_BUTTON_DEFAULT_BORDER_COLOR
        bodyButton1.layer.borderWidth = BODY_BUTTON_DEFAULT_BORDER_WIDTH
        bodyButton1.addTarget(self, action: Selector(("bodyButtonPressed:")),
                               for: .touchUpInside)
        view.addSubview(bodyButton1)

        bodyButton2 = UIButton(frame: CGRect(
            x: bodyButtonX + bodyButtonWidth,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton2.setImage(bodyImages[1], for: .normal)
        bodyButton2.layer.borderColor = BODY_BUTTON_DEFAULT_BORDER_COLOR
        bodyButton2.layer.borderWidth = BODY_BUTTON_DEFAULT_BORDER_WIDTH
        bodyButton2.addTarget(self, action: Selector(("bodyButtonPressed:")),
                              for: .touchUpInside)
        view.addSubview(bodyButton2)
        
        bodyButton3 = UIButton(frame: CGRect(
            x: bodyButtonX + bodyButtonWidth * 2,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton3.setImage(bodyImages[2], for: .normal)
        bodyButton3.layer.borderColor = BODY_BUTTON_DEFAULT_BORDER_COLOR
        bodyButton3.layer.borderWidth = BODY_BUTTON_DEFAULT_BORDER_WIDTH
        bodyButton3.addTarget(self, action: Selector(("bodyButtonPressed:")),
                              for: .touchUpInside)
        view.addSubview(bodyButton3)
        
        bodyButton4 = UIButton(frame: CGRect(
            x: bodyButtonX + bodyButtonWidth * 3,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton4.setImage(bodyImages[3], for: .normal)
        bodyButton4.layer.borderColor = BODY_BUTTON_SELECTED_BORDER_COLOR
        bodyButton4.layer.borderWidth = BODY_BUTTON_SELECTED_BORDER_WIDTH
        bodyButton4.addTarget(self, action: Selector(("bodyButtonPressed:")),
                              for: .touchUpInside)
        view.addSubview(bodyButton4)
        
        selectedBodyButton = bodyButton4
    }
    
    // MARK: Body Button functionality.
    
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
            // Set the previously selected button to default border size/color.
            self.selectedBodyButton.layer.borderWidth = self.BODY_BUTTON_DEFAULT_BORDER_WIDTH
            self.selectedBodyButton.layer.borderColor = self.BODY_BUTTON_DEFAULT_BORDER_COLOR
            
            // Set the selected body button to the selected border size/color.
            sender.layer.borderWidth = self.BODY_BUTTON_SELECTED_BORDER_WIDTH
            sender.layer.borderColor = self.BODY_BUTTON_SELECTED_BORDER_COLOR
            
            // Update the selected body button pointer.
            self.selectedBodyButton = sender
            
            // Update the background body image.
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
//        weak var popOverVC: PopUpViewController? = UIStoryboard(
//            name: "Main", bundle: nil).instantiateViewController(
//                withIdentifier: "popUpView") as? PopUpViewController
//
//        popOverVC!.view.frame = view.frame
//
//        self.addChild(popOverVC!)
//        self.view.addSubview(popOverVC!.view)
//        popOverVC!.didMove(toParent: self)
        let userGuideView = UserGuideController()
        userGuideView.dataSource = self
        present(userGuideView, animated: true, completion: nil)
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
        
        colorSlider.displayPreview(at: CGPoint(x: 0.0, y: 1.0))
        
        // Set callback function for when the color slider's value changes.
        colorSlider.addTarget(
            self,
            action: #selector(changedColor(_:)),
            for: .valueChanged)
        
        view.addSubview(colorSlider)
    }
    
    /**
      Called when the color slider's selected color changes.
      This function updates the face and emoji buttons based on
      the selected color.
     */
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
            
            self.faceButton1.image = newFaceImages[0]
            self.faceButton2.image = newFaceImages[1]
            
            if newFaceImages.count >= 3 {
                self.faceButton3.image = newFaceImages[2]
                self.faceButton3.layer.borderWidth = 0.5
            }
            else {
                self.faceButton3.image = nil
                self.faceButton3.layer.borderWidth = 0
            }
            
            if newFaceImages.count == 4 {
                self.faceButton4.image = newFaceImages[3]
                self.faceButton4.layer.borderWidth = 0.5
            }
            else {
                self.faceButton4.image = nil
                self.faceButton4.layer.borderWidth = 0
            }
        }
    }
    
    //MARK: Emoji Button functionality.
    
    /**
      Called when the user selects an emoji from the emoji column on the
      right side of the view.  A new emoji is created to replace the emoji
      the user is dragging around the screen.
     */
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
}






