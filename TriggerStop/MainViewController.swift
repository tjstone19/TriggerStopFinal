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
    var emojisInView: [UIImageView] = [UIImageView]()
    
    @IBOutlet weak var clearScreenButton: UIButton!
    
    @IBOutlet weak var addPhotoButton: UIButton!

    
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
    var faceImageIV1 :UIImageView!
    var faceImageIV2 :UIImageView!
    var faceImageIV3 :UIImageView!
    var faceImageIV4 :UIImageView!
    
    // View that contains the face button image views.
    var faceButtonContainer :UIView!
    
    /* Face button container coordinates and size as a
       percentage of view's dimensions. */
    let FACE_BUTTON_CONTAINER_X :CGFloat = 0.5
    let FACE_BUTTON_CONTAINER_Y :CGFloat = 0.09
    let FACE_BUTTON_CONTAINER_WIDTH :CGFloat = 0.6
    let FACE_BUTTON_CONTAINER_HEIGHT :CGFloat = 0.11
    
    // Image views for the face buttons.
    var emojiImageIV1 :UIImageView!
    var emojiImageIV2 :UIImageView!
    var emojiImageIV3 :UIImageView!
    var emojiImageIV4 :UIImageView!
    var emojiImageIV5 :UIImageView!
    
    // Emoji button coordinates and size as a percentage of view's dimensions.
    let EMOJI_BUTTON_X :CGFloat = 0.83
    let EMOJI_BUTTON_Y :CGFloat = 0.3
    let EMOJI_BUTTON_WIDTH: CGFloat = 0.15
    let EMOJI_BUTTON_HEIGHT: CGFloat = 0.07
    
    // Vertical spacing between emoji buttons
    let EMOJI_BUTTON_Y_SPACING :CGFloat = 0.05
    
    // Emoji image coordinates relative to where the user touched the screen.
    let NEW_EMOJI_X :CGFloat = 0.15
    let NEW_EMOJI_Y :CGFloat = 0.05
    
    // Emoji image widght and height as percentage of view's dimensions.
    let NEW_EMOJI_WIDTH :CGFloat = 0.15
    let NEW_EMOJI_HEIGHT :CGFloat = 0.15
    
    // Color slider coordinates and size as a percentage of view's dimensions.
    let COLOR_SLIDER_X :CGFloat = 0.05
    let COLOR_SLIDER_Y :CGFloat = 0.24
    let COLOR_SLIDER_WIDTH :CGFloat = 0.05
    let COLOR_SLIDER_HEIGHT :CGFloat = 0.71
    
    var bodyButton1 :UIImageView!
    var bodyButton2 :UIImageView!
    var bodyButton3 :UIImageView!
    var bodyButton4 :UIImageView!

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
        
        clearScreenButton.imageView?.image = UIImage(named: "Trash")
        clearScreenButton.addTarget(self, action: Selector(("clearScreen:")), for: .touchUpInside)
        self.navigationItem.titleView = clearScreenButton
        
        // Create the body background image view.
        setBodyImage()
        initializeFaceButtons()
        initializeEmojiButtons()
        initializeBodyButtons()
        
        initializeColorSlider()
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
        
        // Call the faceButtonPressed function when an image view is selected.
        let tapGesture1 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("faceButtonPressed:")))
        
        let tapGesture2 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("faceButtonPressed:")))
        
        let tapGesture3 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("faceButtonPressed:")))
        
        let tapGesture4 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("faceButtonPressed:")))
        
        
        faceButtonContainer = UIView(frame:
            CGRect(x: width * FACE_BUTTON_CONTAINER_X,
                   y: height * FACE_BUTTON_CONTAINER_Y,
                   width: width * FACE_BUTTON_CONTAINER_WIDTH,
                   height: height * FACE_BUTTON_CONTAINER_HEIGHT))
        
        faceButtonContainer.contentMode = .center
        faceButtonContainer.isUserInteractionEnabled = true
        
        let faceButtonWidth = faceButtonContainer.bounds.width * 0.20
        let faceButtonHeight = faceButtonContainer.bounds.height
        let faceButtonXIncrement :CGFloat = 0.2
        let faceButtonY = height * 0.02
        let faceBorderWidth :CGFloat = 0.5
        
        faceImageIV1 = UIImageView(image: greenFaceImages[0])
        faceImageIV1.layer.borderColor = UIColor.black.cgColor
        faceImageIV1.layer.borderWidth = faceBorderWidth
        faceImageIV1.isUserInteractionEnabled = true
        faceImageIV1.addGestureRecognizer(tapGesture1)
        faceImageIV1.frame = CGRect(
            x: 0,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight)
        
        faceImageIV2 = UIImageView(image: greenFaceImages[1])
        faceImageIV2.isUserInteractionEnabled = true
        faceImageIV2.layer.borderColor = UIColor.black.cgColor
        faceImageIV2.layer.borderWidth = faceBorderWidth
        faceImageIV2.addGestureRecognizer(tapGesture2)
        faceImageIV2.frame = CGRect(
            x: faceButtonContainer.bounds.width * faceButtonXIncrement,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight)
        
        faceImageIV3 = UIImageView()
        faceImageIV3.layer.borderColor = UIColor.black.cgColor
        faceImageIV3.isUserInteractionEnabled = true
        faceImageIV3.addGestureRecognizer(tapGesture3)
        faceImageIV3.frame = CGRect(
            x: faceButtonContainer.bounds.width * (faceButtonXIncrement * 2),
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight)
        
        faceImageIV4 = UIImageView()
        faceImageIV4.layer.borderColor = UIColor.black.cgColor
        faceImageIV4.isUserInteractionEnabled = true
        faceImageIV4.addGestureRecognizer(tapGesture4)
        faceImageIV4.frame = CGRect(
            x: faceButtonContainer.bounds.width * (faceButtonXIncrement * 3),
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight)
        
        faceButtonContainer.addSubview(faceImageIV1)
        faceButtonContainer.addSubview(faceImageIV2)
        faceButtonContainer.addSubview(faceImageIV3)
        faceButtonContainer.addSubview(faceImageIV4)
        
        
        view.addSubview(faceButtonContainer)
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
        
        // Call the faceButtonPressed function when an image view is selected.
        let tapGesture1 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("emojiButtonPressed:")))
        
        let tapGesture2 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("emojiButtonPressed:")))
        
        let tapGesture3 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("emojiButtonPressed:")))
        
        let tapGesture4 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("emojiButtonPressed:")))
        
        let tapGesture5 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("emojiButtonPressed:")))
        
        
        
        let emojiButtonWidth :CGFloat = width * EMOJI_BUTTON_WIDTH
        let emojiButtonHeight :CGFloat = height * EMOJI_BUTTON_HEIGHT
        
        let emojiButtonX :CGFloat = width * EMOJI_BUTTON_X
        let emojiButtonY :CGFloat = height * EMOJI_BUTTON_Y
        let emojiYIncrement :CGFloat = height * EMOJI_BUTTON_Y_SPACING
            + emojiButtonHeight
        
        
        emojiImageIV1 = UIImageView(image: greenEmojiImages[0])
        emojiImageIV1.isUserInteractionEnabled = true
        emojiImageIV1.addGestureRecognizer(tapGesture1)
        emojiImageIV1.frame = CGRect(
            x: emojiButtonX,
            y: emojiButtonY,
            width: emojiButtonWidth,
            height: emojiButtonHeight)
        
        emojiImageIV2 = UIImageView(image: greenEmojiImages[1])
        emojiImageIV2.isUserInteractionEnabled = true
        emojiImageIV2.addGestureRecognizer(tapGesture2)
        emojiImageIV2.frame = CGRect(
            x: emojiButtonX,
            y:  emojiButtonY + emojiYIncrement,
            width: emojiButtonWidth,
            height: emojiButtonHeight)
        
        emojiImageIV3 = UIImageView(image: greenEmojiImages[2])
        emojiImageIV3.isUserInteractionEnabled = true
        emojiImageIV3.addGestureRecognizer(tapGesture3)
        emojiImageIV3.frame = CGRect(
            x:  emojiButtonX,
            y:  emojiButtonY + emojiYIncrement * 2,
            width: emojiButtonWidth,
            height: emojiButtonHeight)
        
        emojiImageIV4 = UIImageView(image: greenEmojiImages[3])
        emojiImageIV4.isUserInteractionEnabled = true
        emojiImageIV4.addGestureRecognizer(tapGesture4)
        emojiImageIV4.frame = CGRect(
            x: emojiButtonX,
            y: emojiButtonY + emojiYIncrement * 3,
            width: emojiButtonWidth,
            height: emojiButtonHeight)
        
        emojiImageIV5 = UIImageView(image: greenEmojiImages[4])
        emojiImageIV5.isUserInteractionEnabled = true
        emojiImageIV5.addGestureRecognizer(tapGesture5)
        emojiImageIV5.frame = CGRect(
            x: emojiButtonX,
            y: emojiButtonY + emojiYIncrement * 4,
            width: emojiButtonWidth,
            height: emojiButtonHeight)
        
        view.addSubview(emojiImageIV1)
        view.addSubview(emojiImageIV2)
        view.addSubview(emojiImageIV3)
        view.addSubview(emojiImageIV4)
        view.addSubview(emojiImageIV5)
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
    @objc func faceButtonPressed(_ sender: UITapGestureRecognizer) {
        
        // Get the face image view that was tapped by the user.
        let view = sender.view
        let touchLocation = sender.location(in: view)
        let selectedFaceIV :UIImageView? = view?.hitTest(touchLocation, with: nil) as? UIImageView
        
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
        
        // Call the faceButtonPressed function when an image view is selected.
        let tapGesture1 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("bodyButtonPressed:")))
        
        let tapGesture2 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("bodyButtonPressed:")))
        
        let tapGesture3 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("bodyButtonPressed:")))
        
        let tapGesture4 :UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: Selector(("bodyButtonPressed:")))
        
        
        let bodyButtonContainer = UIView(frame:
            CGRect(x: width * 0.3,
                   y: height * 0.09,
                   width: width * 0.3,
                   height: height * 0.1))

        bodyButtonContainer.contentMode = .center
        bodyButtonContainer.isUserInteractionEnabled = true
        
        
        let bodyButtonWidth = width * 0.11
        let bodyButtonHeight = height * 0.11
        let bodyButtonX = width * 0.02
        let bodyButtonY = height * 0.11
        let bodyBorderWidth :CGFloat = 0.5
        
        bodyButton1 = UIImageView()
        bodyButton1.image = bodyImages[0]
        bodyButton1.layer.borderColor = UIColor.black.cgColor
        bodyButton1.layer.borderWidth = bodyBorderWidth
        bodyButton1.isUserInteractionEnabled = true
        bodyButton1.addGestureRecognizer(tapGesture1)
        bodyButton1.frame = CGRect(
            x: bodyButtonX,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight)
        
        view.addSubview(bodyButton1)
        
        
        bodyButton2 = UIImageView()
        bodyButton2.image = bodyImages[1]
        bodyButton2.layer.borderColor = UIColor.black.cgColor
        bodyButton2.layer.borderWidth = bodyBorderWidth
        bodyButton2.isUserInteractionEnabled = true
        bodyButton2.addGestureRecognizer(tapGesture2)
        bodyButton2.frame = CGRect(
            x: bodyButtonX + bodyButtonWidth,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight)
        
        view.addSubview(bodyButton2)
        
        bodyButton3 = UIImageView()
        bodyButton3.image = bodyImages[2]
        bodyButton3.layer.borderColor = UIColor.black.cgColor
        bodyButton3.layer.borderWidth = bodyBorderWidth
        bodyButton3.isUserInteractionEnabled = true
        bodyButton3.addGestureRecognizer(tapGesture3)
        bodyButton3.frame = CGRect(
            x: bodyButtonX + bodyButtonWidth * 2,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight)
        
        view.addSubview(bodyButton3)
        
        bodyButton4 = UIImageView()
        bodyButton4.image = bodyImages[3]
        bodyButton4.layer.borderColor = UIColor.black.cgColor
        bodyButton4.layer.borderWidth = bodyBorderWidth
        bodyButton4.isUserInteractionEnabled = true
        bodyButton4.addGestureRecognizer(tapGesture4)
        bodyButton4.frame = CGRect(
            x: bodyButtonX + bodyButtonWidth * 3,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight)
        
        view.addSubview(bodyButton4)
    }
    
    
    //MARK: Body Button functionality.
    
    /**
     Called when a body button is pressed.
     
     Sets the body image to the selected button's image.
     */
    @objc func bodyButtonPressed(_ sender: UITapGestureRecognizer) {
        
        // Get the face image view that was tapped by the user.
        let view = sender.view
        let touchLocation = sender.location(in: view)
        let selectedBodyIV :UIImageView? = view?.hitTest(touchLocation, with: nil) as? UIImageView
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
        for emoji in emojisInView {
            emoji.removeFromSuperview()
        }
        
        if faceImageIV != nil {
            faceImageIV.image = nil
        }
        emojisInView.removeAll()
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
            
            self.emojiImageIV1.image = newEmojiImages[0]
            self.emojiImageIV2.image = newEmojiImages[1]
            self.emojiImageIV3.image = newEmojiImages[2]
            self.emojiImageIV4.image = newEmojiImages[3]
            self.emojiImageIV5.image = newEmojiImages[4]
            
            self.faceImageIV1.image = newFaceImages[0]
            self.faceImageIV2.image = newFaceImages[1]
            
            if newFaceImages.count >= 3 {
                self.faceImageIV3.image = newFaceImages[2]
                self.faceImageIV3.layer.borderWidth = 0.5
            }
            else {
                self.faceImageIV3.image = nil
                self.faceImageIV3.layer.borderWidth = 0
            }
            
            if newFaceImages.count == 4 {
                self.faceImageIV4.image = newFaceImages[3]
                self.faceImageIV4.layer.borderWidth = 0.5
            }
            else {
                self.faceImageIV4.image = nil
                self.faceImageIV4.layer.borderWidth = 0
            }
        }
    }
    
    //MARK: Emoji Button functionality.
    
    @objc func emojiButtonPressed(_ sender: UITapGestureRecognizer) {
        
        // Get the emoji image view that was tapped by the user.
        let tapView = sender.view

        let touchLocationInEmojiButton = sender.location(in: tapView)
        let touchLocationInView = sender.location(in: self.view)
        let selectedEmojiIV :UIImageView? = tapView?.hitTest(touchLocationInEmojiButton, with: nil) as? UIImageView
        
        if selectedEmojiIV?.image == nil {
            return
        }
        
        let emojiView = UIImageView(image: selectedEmojiIV?.image)
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
        let emojiView = sender.view!
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

