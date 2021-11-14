//
//  ContentView.swift
//  SleepApp
//
//  Created by Jonathan Pang on 11/13/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var pass = Pass()
    @ObservedObject var join = joinUser()
    
    var body: some View {
        switch pass.currentScreen {
        case 0:
            MainView()
        default:
            MainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
