//
//  main.swift
//  swiftOOP
//
//  Created by macpro on 10.10.2023.
//

import Foundation

let cihangir = Kullanici(isim: "cihangir", yas: 23, meslek: "yazilim", tip: .AdminKullanici)

print(cihangir.meslek)

cihangir.meslek = "ogrenci"

print(cihangir.meslek)

cihangir.ornekFonksiyon()

print(cihangir.tip)

print(cihangir.sacRenginiAl())




let zeynep = OzelKullanici(isim: "zeynep", yas: 70, meslek: "ogretmen", tip: .NormalKullanici)

print(zeynep.meslek)

zeynep.yeniFonksiyon()

zeynep.ornekFonksiyon()

