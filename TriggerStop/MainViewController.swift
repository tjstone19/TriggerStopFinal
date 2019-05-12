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
    
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var emojiButton: UIButton!
    @IBOutlet weak var percentLabel: UILabel!
    
    // Image view for the body.
    var bodyIV :UIImageView!
    
    // Image view for the face image displayed over the body's head.
    var faceImageIV :UIImageView!

    // Image views for the face buttons.
    var faceImageIV1 :UIImageView!
    var faceImageIV2 :UIImageView!
    var faceImageIV3 :UIImageView!
    var faceImageIV4 :UIImageView!
    
    var faceButton :UIButton!
    
    // View that contains the face button image views.
    var faceButtonContainer :UIView!

    var greenFaceImages = [UIImage]()
    var blueFaceImages = [UIImage]()
    var orangeFaceImages = [UIImage]()
    var redFaceImages = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the body background image view.
        setBodyImage()
        initializeFaceButtons()
        
        // Set the button's image to to the emoji image.
        emojiButton.setImage(
            UIImage(named: "splash"),
            for: .normal)
        
        initializeColorSlider()
    }
    
    /**
        Sets the background body image and face image.
     */
    func setBodyImage() {
        bodyIV = UIImageView(image: UIImage(named: "BlackBody"))
        bodyIV.frame = CGRect(
            x: view.frame.width * 0.15,
            y: view.frame.height * 0.2,
            width: view.frame.width * 0.67,
            height: view.frame.height * 0.75)
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
            CGRect(x: view.frame.width * 0.3,
                   y: view.frame.height * 0.1,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.1))
        
        faceButtonContainer.contentMode = .center
        faceButtonContainer.isUserInteractionEnabled = true
        
        let faceButtonWidth = faceButtonContainer.bounds.width * 0.20
        let faceButtonHeight = faceButtonContainer.bounds.height
        
        
        faceImageIV1 = UIImageView(image: greenFaceImages[0])
        faceImageIV1.isUserInteractionEnabled = true
        faceImageIV1.addGestureRecognizer(tapGesture1)
        faceImageIV1.frame = CGRect(
            x: 0,
            y: 0,
            width: faceButtonWidth,
            height: faceButtonHeight)
        
        faceImageIV2 = UIImageView(image: greenFaceImages[1])
        faceImageIV2.isUserInteractionEnabled = true
        faceImageIV2.addGestureRecognizer(tapGesture2)
        faceImageIV2.frame = CGRect(
            x: faceButtonContainer.bounds.width * 0.25,
            y: 0,
            width: faceButtonWidth,
            height: faceButtonHeight)
        
        faceImageIV3 = UIImageView()
        faceImageIV3.isUserInteractionEnabled = true
        faceImageIV3.addGestureRecognizer(tapGesture3)
        faceImageIV3.frame = CGRect(
            x: faceButtonContainer.bounds.width * 0.50,
            y: 0,
            width: faceButtonWidth,
            height: faceButtonHeight)
        
        faceImageIV4 = UIImageView()
        faceImageIV4.isUserInteractionEnabled = true
        faceImageIV4.addGestureRecognizer(tapGesture4)
        faceImageIV4.frame = CGRect(
            x: faceButtonContainer.bounds.width * 0.75,
            y: 0,
            width: faceButtonWidth,
            height: faceButtonHeight)
        
        faceButtonContainer.addSubview(faceImageIV1)
        faceButtonContainer.addSubview(faceImageIV2)
        faceButtonContainer.addSubview(faceImageIV3)
        faceButtonContainer.addSubview(faceImageIV4)
        
        
        view.addSubview(faceButtonContainer)
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
            y: view.frame.height * 0.2,
            width: view.frame.width * 0.05,
            height: view.frame.height * 0.70)
        
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
                              y: view.frame.height * 0.2,
                              width: view.frame.width * 0.32,
                              height: view.frame.height * 0.22))
            view.addSubview(faceImageIV)
        }
        
        // Get the face image view that was tapped by the user.
        let view = sender.view
        let touchLocation = sender.location(in: view)
        let selectedFaceIV :UIImageView? = view?.hitTest(touchLocation, with: nil) as? UIImageView
        
        DispatchQueue.main.async {
            self.faceImageIV.image = selectedFaceIV?.image
        }
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(
        picker: UIImagePickerController!,
        didFinishPickingImage image: UIImage!,
        editingInfo: NSDictionary!) {
        
        self.dismiss(animated: true, completion: { () -> Void in
        })
    }
    
    @objc func changedColor(_ slider: ColorSlider) {
        let percentage: CGFloat = slider.currentPercentage * 100
        percentLabel.text = String(format: "%.2f", percentage)
        
        var newImages :[UIImage]
        
        if percentage <= 25 {
            newImages = self.greenFaceImages
        }
        else if percentage <= 50 {
            newImages = self.blueFaceImages
        }
        else if percentage <= 75 {
            newImages = self.orangeFaceImages
        }
        else {
            newImages = self.redFaceImages
        }
        
        DispatchQueue.main.async {
            self.faceImageIV1.image = newImages[0]
            self.faceImageIV2.image = newImages[1]
            
            if newImages.count >= 3 {
                self.faceImageIV3.image = newImages[2]
            }
            else {
                self.faceImageIV3.image = nil
            }
            
            if newImages.count == 4 {
                self.faceImageIV4.image = newImages[3]
            }
            else {
                self.faceImageIV4.image = nil
            }
        }
    }
    
    /***
     Creates an Emoji Image view and adds it to the view.
     */
    @IBAction func emojiButtonPressed(_ sender: UIButton) {
        
        let newEmoji = UIImage(named: "splash")
        let emojiView = UIImageView(image: newEmoji)
        emojiView.frame.size = newEmoji!.size
        
        
        let button_x = self.emojiButton.frame.origin.x
        let button_y = self.emojiButton.frame.origin.y
        
        emojiView.frame = CGRect(
            x: button_x + 10,
            y: button_y + 10,
            width: newEmoji!.size.width,
            height: newEmoji!.size.height
        )
        
        
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action:#selector(MainViewController.moveEmoji(_:)))
        
        
        emojiView.isUserInteractionEnabled = true
        emojiView.addGestureRecognizer(panGesture)
        emojisInView.append(emojiView)
        
        print("Emojies in view: \(emojisInView.count)")
        self.view.addSubview(emojiView)
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

