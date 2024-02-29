//
//  OzelKullanici.swift
//  swiftOOP
//
//  Created by macpro on 11.10.2023.
//

import Foundation

class OzelKullanici : Kullanici {
    
    func yeniFonksiyon() {
        print("yeni fonksiyon calistirildi")
    }
    
    override func ornekFonksiyon() {
        super.ornekFonksiyon()
        print("ozelden calistirilan ornek buydu.")
    }
    
}
