//
//  kullanici.swift
//  swiftOOP
//
//  Created by macpro on 10.10.2023.
//

import Foundation

enum KullaniciTipi {
    case AdminKullanici
    case NormalKullanici
    case YetkisizKullanici
}

class Kullanici  {
    
    var isim = ""
    var yas = 0
    var meslek = ""
    var tip : KullaniciTipi
    private var sacRengi = "siyah"
    
    
    //initalizer
    
    init(isim : String , yas : Int , meslek : String , tip : KullaniciTipi) {
        print("init cagirildi")
        self.isim = isim
        self.yas = yas
        self.meslek = meslek
        self.tip = tip
    }
    
    func ornekFonksiyon() {
        print("ornek fonksiyon calistirildi")
    }
    
    
    // Acces Levels -  erişilebilirlik seviyesi
    // open , public , internal , fileprivate , private
    
    private func testFonksiyonu() {
        print("test")
    }
    // sadece class içinde kullanıcağın şeyleri "private" kullan.
    // sadece class içinde kullanmıyıcaksan "private" kullama.
    
    func sacRenginiAl() -> String {
        return self.sacRengi
    }
    
}
