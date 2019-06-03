//
//  MainViewController.swift
//  TriggerStop
//
//  Created by T.J. Stone on 5/4/19.
//  Copyright © 2019 T.J. Stone. All rights reserved.
//

import UIKit
import ColorSlider

class MainViewController: UIViewController, UIImagePickerControllerDelegate {
    // Stores all of the emojis on the screen.
    var emojisInView: [UIImageView] = [UIImageView]()
    
    @IBOutlet weak var clearScreenButton: UIButton!
    
    @IBOutlet weak var addPhotoButton: UIButton!

    
    // Image view for the body.
    var bodyIV :UIImageView!
    
    // Image view for the face image displayed over the body's head.
    var faceImageIV :UIImageView!

    // Image views for the face buttons.
    var faceImageIV1 :UIImageView!
    var faceImageIV2 :UIImageView!
    var faceImageIV3 :UIImageView!
    var faceImageIV4 :UIImageView!
    
    // View that contains the face button image views.
    var faceButtonContainer :UIView!
    
    // Image views for the face buttons.
    var emojiImageIV1 :UIImageView!
    var emojiImageIV2 :UIImageView!
    var emojiImageIV3 :UIImageView!
    var emojiImageIV4 :UIImageView!
    var emojiImageIV5 :UIImageView!
    
    var bodyButton1 :UIImageView!
    var bodyButton2 :UIImageView!
    var bodyButton3 :UIImageView!
    var bodyButton4 :UIImageView!
    
    // View that contains the emoji button image views.
    var emojiButtonContainer :UIView!

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
        
//        clearScreenButton = UIButton(frame: CGRect(
//            x: 0,
//            y: 0,
//            width: view.frame.width * 0.15,
//            height: view.frame.height * 0.15))
        
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
            x: view.frame.width * 0.15,
            y: view.frame.height * 0.24,
            width: view.frame.width * 0.67,
            height: view.frame.height * 0.74)
        view.addSubview(bodyIV)
    }
    
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
            CGRect(x: view.frame.width * 0.5,
                   y: view.frame.height * 0.09,
                   width: view.frame.width * 0.6,
                   height: view.frame.height * 0.11))
        
        faceButtonContainer.contentMode = .center
        faceButtonContainer.isUserInteractionEnabled = true
        
        let faceButtonWidth = faceButtonContainer.bounds.width * 0.20
        let faceButtonHeight = faceButtonContainer.bounds.height
        let faceButtonXIncrement :CGFloat = 0.2
        let faceButtonY = view.frame.height * 0.02
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
        
        emojiButtonContainer = UIView(frame:
            CGRect(x: view.frame.width * 0.83,
                   y: view.frame.height * 0.25,
                   width: view.frame.width * 0.16,
                   height: view.frame.height * 0.7))
        
        let emojiButtonWidth :CGFloat = view.frame.width * 0.15
        let emojiButtonHeight :CGFloat = view.frame.height * 0.07
        
        let emojiButtonX :CGFloat = view.frame.width * 0.83
        let emojiButtonY :CGFloat = view.frame.height * 0.3
        let emojiYIncrement :CGFloat = emojiButtonHeight + view.frame.height * 0.05
        
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
        
//        emojiButtonContainer.addSubview(emojiImageIV1)
//        emojiButtonContainer.addSubview(emojiImageIV2)
//        emojiButtonContainer.addSubview(emojiImageIV3)
//        emojiButtonContainer.addSubview(emojiImageIV4)
//        emojiButtonContainer.addSubview(emojiImageIV5)
//
//        view.addSubview(emojiButtonContainer)
        view.addSubview(emojiImageIV1)
        view.addSubview(emojiImageIV2)
        view.addSubview(emojiImageIV3)
        view.addSubview(emojiImageIV4)
        view.addSubview(emojiImageIV5)
    }
    
    
    
    /**
        Sets up the color slider and adds it to the view.
     */
    func initializeColorSlider() {
        // Set up the color slider.
        let colorSlider = ColorSlider(
            orientation: .vertical,
            previewSide: .right)
        
        colorSlider.frame = CGRect(
            x: view.frame.width * 0.05,
            y: view.frame.height * 0.24,
            width: view.frame.width * 0.05,
            height: view.frame.height * 0.71)
        
        // Set callback function for when the color slider's value changes.
        colorSlider.addTarget(
            self,
            action: #selector(changedColor(_:)),
            for: .valueChanged)
        
        view.addSubview(colorSlider)
    }
    
    /**
        Called when a face button is pressed.
     
        Creates and image view and sets it's image to the selected
        face. The image view is presented over the body's head.
    */
    @objc func faceButtonPressed(_ sender: UITapGestureRecognizer) {
        
        if faceImageIV == nil {
            faceImageIV = UIImageView(
                frame: CGRect(x: view.frame.width * 0.325,
                              y: view.frame.height * 0.24,
                              width: view.frame.width * 0.32,
                              height: view.frame.height * 0.22))
            view.addSubview(faceImageIV)
            view.sendSubviewToBack(faceImageIV)
            view.sendSubviewToBack(bodyIV)
        }
        
        // Get the face image view that was tapped by the user.
        let view = sender.view
        let touchLocation = sender.location(in: view)
        let selectedFaceIV :UIImageView? = view?.hitTest(touchLocation, with: nil) as? UIImageView
        
        DispatchQueue.main.async {
            self.faceImageIV.image = selectedFaceIV?.image
        }
    }
    
    func loadBodyImages() {
        bodyImages.append(UIImage(named: "WhiteBody")!)
        bodyImages.append(UIImage(named: "YellowBody")!)
        bodyImages.append(UIImage(named: "BrownBody")!)
        bodyImages.append(UIImage(named: "BlackBody")!)
    }
    
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
            CGRect(x: view.frame.width * 0.3,
                   y: view.frame.height * 0.09,
                   width: view.frame.width * 0.3,
                   height: view.frame.height * 0.1))

        bodyButtonContainer.contentMode = .center
        bodyButtonContainer.isUserInteractionEnabled = true
        
        
        let bodyButtonWidth = view.frame.width * 0.11
        let bodyButtonHeight = view.frame.height * 0.11
        let bodyButtonX = view.frame.width * 0.02
        let bodyButtonY = view.frame.height * 0.11
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
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    
//    @objc func imagePickerController(picker: UIImagePickerController!,
//                               didFinishPickingImage image: UIImage!,
//                               editingInfo: NSDictionary!) {
//
//        self.dismiss(animated: true, completion: { () -> Void in
//        })
//
//        let emojiWidth = self.view.bounds.width * 0.15
//        let emojiHeight = emojiWidth
//        let newEmojiIV :UIImageView = UIImageView(image: image)
//        newEmojiIV.frame = CGRect(
//            x: view.frame.width / 2 - emojiWidth,
//            y: view.frame.height / 2 - emojiHeight,
//            width: emojiWidth,
//            height: emojiHeight)
//
//        view.addSubview(newEmojiIV)
//    }
    
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
            x: touchLocationInView.x - view.frame.width * 0.15,
            y: touchLocationInView.y - view.frame.height * 0.05,
            width: self.view.bounds.width * 0.15,
            height: self.view.bounds.width * 0.15)

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
}

