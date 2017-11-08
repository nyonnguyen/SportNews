//
//  Models.swift
//  SportNews
//
//  Created by Nyon Nguyen on 11/3/17.
//  Copyright © 2017 Nyon Nguyen. All rights reserved.
//

import UIKit

class Player: NSObject {
    var rank: Int = 0
    var avatar: String = "avdefault"
    var name: String
    var number: Int
    var club: Club
    
    init(rank: Int, avatar: String, name: String, number: Int, club: Club) {
        self.rank = rank
        self.avatar = avatar
        self.name = name
        self.number = number
        self.club = club
    }
}


enum ClubEnum {
    case BARCALONA
    case REALMARID
    case MANU
    case MANC
    case ASERNAL
    case LIVERPOOL
    
    func getData() -> Club {
        switch self {
        case .BARCALONA:
            return Club(logo: "logo-barcelona", fullName: "barcelona F.C", website: "www.barcelonafc.com", background: "bg1", colors: [UIColor.blue, UIColor.red])
        case .REALMARID:
            return Club(logo: "logo-realmarid", fullName: "real marid F.C", website: "www.realmaridfc.com",  background: "bg2", colors: [UIColor.cyan, UIColor.white])
        case .MANU:
            return Club(logo: "logo-manu", fullName: "manchester united F.C", website: "www.manufc.com",  background: "bg3", colors: [UIColor.yellow, UIColor.red])
        case .MANC:
            return Club(logo: "logo-mancity", fullName: "manchester city F.C", website: "www.mancityfc.com",  background: "bg4", colors: [UIColor.yellow, UIColor.cyan])
        case .ASERNAL:
            return Club(logo: "logo-asernal", fullName: "asernal F.C", website: "www.asernalfc.com",  background: "bg5", colors: [UIColor.yellow, UIColor.red])
        case .LIVERPOOL:
            return Club(logo: "logo-liverpool", fullName: "liverpool F.C", website: "www.liverpoolfc.com",  background: "bg6", colors: [UIColor.cyan, UIColor.red])
        }
    }
}

class Club {
    var logo: String
    var fullName: String
    var website: String
    var background: String
    var colors = [UIColor.black, UIColor.white]
    
    init(logo: String, fullName: String, website: String, background: String, colors: [UIColor]) {
        self.logo = logo
        self.fullName = fullName
        self.website = website
        self.background = background
        self.colors = colors
    }
}
