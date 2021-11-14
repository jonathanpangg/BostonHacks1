//
//  NotificationStatus.swift
//  SleepApp
//
//  Created by Jonathan Pang on 11/13/21.
//

import SwiftUI

class NotificationStatus: ObservableObject {
    @Published var status = NotificationData()
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "status") {
            if let decoded = try? JSONDecoder().decode(NotificationData.self, from: data) {
                self.status = decoded
                return
            }
        }
    }
}

struct NotificationData: Codable {
    var status: String
    
    init() { self.status = "ON" }
}
