//
//  SleepData.swift
//  SleepApp
//
//  Created by Jonathan Pang on 11/13/21.
//

import SwiftUI

struct SleepData: Codable {
    var id: String
    var minsOfSleep: Int
    var date: String
    
    init() {
        id = UUID().uuidString
        minsOfSleep = 0
        date = ""
    }
}
