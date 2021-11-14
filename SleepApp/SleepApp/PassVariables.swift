//
//  PassVariables.swift
//  SleepApp
//
//  Created by Jonathan Pang on 11/13/21.
//

import SwiftUI

class Pass: ObservableObject {
    @Published var currentScreen: Int = 0

    init() { }
}
