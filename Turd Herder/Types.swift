//
//  Types.swift
//  Turd Herder
//
//  Created by Brent Michalski on 7/13/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import Foundation

enum GameState: Int {
    case initial  = 0
    case start    = 1
    case playing  = 2
    case win      = 3
    case restart  = 4
    case pause    = 5
    case nocamera = 6
    case unpause  = 7
}

enum GameSound: Int {
    case on  = 0
    case off = 1
}

enum GameMusic: Int {
    case on  = 0
    case off = 1
}



