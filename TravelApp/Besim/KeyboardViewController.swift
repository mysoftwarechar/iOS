//
//  KeyboardViewController.swift
//  Besim
//
//  Created by macpro on 24.02.2024.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Besim Tibuk Keyboard oluşturmak için.
        //Bu şekilde bir sürü image kullanarak hepsini tıklanabilir yapıp , özel bir klavye yapabilirsin
        let besimButton = UIButton(type: UIButton.ButtonType.system)
        besimButton.frame = CGRect(x: 0, y: 00, width: 390, height: 270)
        besimButton.setBackgroundImage(UIImage(named: "besim.webp"), for: UIControl.State.normal)
        besimButton.addTarget(self, action: #selector(besimTapped), for: UIControl.Event.touchUpInside)
        view.addSubview(besimButton)
        
        
        
        
        
        
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    //Besim Tibuk Keyboard oluşturmak için ilgili @objc func
    @objc func besimTapped() {
        
        //Besim Button'a tıklandığında ,  ilgili yere "TRT'yi satıcam!" yazdırır.
        let textProxy = textDocumentProxy as UITextDocumentProxy
        textProxy.insertText("TRT'yi satıcam!")
        
    }
    
    
    
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
