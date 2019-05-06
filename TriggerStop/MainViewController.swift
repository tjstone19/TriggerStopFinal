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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the body background image view.
        let bodyImage = UIImage(named: "BlackBody")
        let bodyIV = UIImageView(image: bodyImage)
        // initial - x=0.2, y 0.2, width 0.75, height 0.75
        bodyIV.frame = CGRect(
            x: view.frame.width * 0.15,
            y: view.frame.height * 0.2,
            width: view.frame.width * 0.67,
            height: view.frame.height * 0.7)
        view.addSubview(bodyIV)
        
        // Set the button's image to to the emoji image.
        emojiButton.setImage(UIImage(named: "splash"), for: .normal)
        
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
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    
    @objc func changedColor(_ slider: ColorSlider) {
        let percentage: CGFloat = slider.currentPercentage * 100
        percentLabel.text = String(format: "%.2f", percentage)
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

