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
     * Moves the face ImageView around the screen.
     *
     * Removes the face image from the screen if the user drags it up towards
     * and intersects the toolbar.
     *
     - Parameter sender: The touch event caused by the user touching the screen.
     */
    @objc func moveFace(_ sender: UIPanGestureRecognizer) {
        guard sender.view != nil && sender.view == self.faceImageIV else {return}
        
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = sender.translation(in: self.faceImageIV.superview)
        
        if sender.state == .began {
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
}


/**
 * Extension for camera and camera roll functionality.
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
    
    func showAlertWith(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

