import Foundation
import UIKit

/**
 * Extension for moving the emoji views around the screen.
 */
extension MainViewController {
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
            newEmoji.contentMode = .scaleAspectFit
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
        if sender.state == .ended {
            if emojiView.center.x > width * EMOJI_VIEW_MAX_X {
                UIView.animate(withDuration: 0.3, animations: {
                    emojiView.alpha = 0.0
                }, completion: { (finished) in
                    emojiView.removeFromSuperview()
                })
            }
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

/**
 * Extension for moving the face image view around the screen.
 */
extension MainViewController {
    /**
      Moves the face ImageView around the screen.
     
      Removes the face image from the screen if it's center is not contained
      within the body image view's bounds.
      
     
      - Parameter sender: The touch event caused by the user touching the screen.
     */
    @objc func moveFaceOffScreen(_ sender: UIPanGestureRecognizer) {
        guard sender.view != nil && sender.view == self.faceImageIV else {return}
        
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = sender.translation(in: self.view)
        
        if sender.state == .began {
            // Temporarily disable face image layout constraints so it can be
            // moved around the screen.
            self.faceImageIV.horizontalConstraint?.isActive = false
            self.faceImageIV.verticalConstraint?.isActive = false
            
            // Save the view's original position.
            self.faceInitialCenter = self.faceImageIV.center
        }
            
        else if sender.state == .ended {
            if self.faceImageIV.center.y < height * FACE_IMAGE_MIN_Y ||
                self.faceImageIV.center.x > width * FACE_IMAGE_MAX_X {
                UIView.animate(withDuration: 0.3, animations: {
                    self.faceImageIV.alpha = 0.0
                }, completion: { (finished) in
                    self.faceImageIV.removeFromSuperview()
                    self.faceImageIV = nil
                })
            }
            else {
                // Return face to original location if it is not
                // being removed from the view.
                self.faceImageIV.horizontalConstraint?.isActive = true
                self.faceImageIV.verticalConstraint?.isActive = true
                self.faceImageIV.center = faceInitialCenter
            }
        }
            
        else if sender.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(
                x: faceInitialCenter.x + translation.x,
                y: faceInitialCenter.y + translation.y)
            self.faceImageIV.center = newCenter
        }
            
        else {
            // On cancellation, return the piece to its original location.
            self.faceImageIV.center = faceInitialCenter
        }
    }
    
    /**
        Moves the face button around the screen.
     
        The selected face image's frame is enlarged when the user initiates the
        pan gesture.  Sets the body's face image if the moved face image is
        contained within the body image view's bounds at the end of the
        drag sequence.
     
        - parameter sender: The pan gesture recogonizer attached to the moving
            face image.
     */
    @objc func moveFaceOnScreen(_ sender: UIPanGestureRecognizer) {
        guard sender.view != nil else {return}
        guard let faceView: UIImageView = sender.view! as? UIImageView else {return}
        
//        let faceView: UIImageView = sender.view! as! UIImageView
        
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = sender.translation(in: faceView.superview)
        
        if sender.state == .began {
            // Save the view's original position.
            self.faceInitialCenter = faceView.center
            
            // Add a replacement EmojiView in the emoji button column.
            let newFaceFrame: CGRect = faceView.frame
            
            let newFace: UIImageView = UIImageView(frame: newFaceFrame)
            newFace.image = faceView.image
            newFace.contentMode = .scaleToFill
            newFace.layer.borderColor = faceView.layer.borderColor
            newFace.layer.borderWidth = faceView.layer.borderWidth
            newFace.isUserInteractionEnabled = true
            newFace.addGestureRecognizer(UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveFaceOnScreen:"))))
            self.view.addSubview(newFace)
            
            DispatchQueue.main.async {
                if faceView == self.faceButton1 {
                    self.faceButton1 = newFace
                }
                else if faceView == self.faceButton2 {
                    self.faceButton2 = newFace
                }
                else if faceView == self.faceButton3 {
                    self.faceButton3 = newFace
                }
                else if faceView == self.faceButton4 {
                    self.faceButton4 = newFace
                }
            }
            
            // Increase width and height of moving face.
            let faceViewHeightWidth = bodyIV.frame.width * (bodyIV.frame.height
                / bodyIV.frame.width * FACE_IMAGE_WIDTH_TO_HEIGHT_RATIO)

            faceView.frame = CGRect(
                origin: faceView.frame.origin,
                size: CGSize(
                    width: faceViewHeightWidth,
                    height: faceViewHeightWidth))
            faceView.layer.masksToBounds = true
            faceView.clipsToBounds = true
            faceView.layer.cornerRadius = faceView.bounds.size.width / 2.0
        }
        
        if sender.state == .ended {
            
            // Set the body face image if the dragged face's center is contained
            // within the body image view.
            if self.bodyIV.frame.contains(faceView.center) {
                self.setFaceImage(image: faceView.image)
            }
            faceView.removeFromSuperview()
        }
        
        if sender.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(
                x: faceInitialCenter.x + translation.x,
                y: faceInitialCenter.y + translation.y)
            faceView.center = newCenter
        }
    }
}


/**
  Extension for camera and camera roll functionality.
 */
extension MainViewController: UIImagePickerControllerDelegate {
    
    //MARK: Get the selected picture from camera or library.
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        setFaceImage(image: selectedImage)
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
    
    /**
      Presents the camera or photo gallery so the user can supply and photo
      for the body face image.
     
      - Parameter source: Means in which the user will provide a photo for
        the bodies face image. Must be .camera or .photoLibrary
     */
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
        
        UIImageWriteToSavedPhotosAlbum(
            selectedImage,
            self,
            #selector(image(_:didFinishSavingWithError:contextInfo:)),
            nil)
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
    
    /**
      Display's a pop up message to the user with the given title and message.
     
      - Parameter title: Title of the pop up message.
      - Parameter message: The text to be displayed in the pop up message.
     */
    func showAlertWith(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

