//
//  UserData.swift
//  SleepApp
//
//  Created by Jonathan Pang on 11/13/21.
//

import SwiftUI

class joinUser: ObservableObject {
    @Published var user = [User]()
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "saveUser") {
            if let decoded = try? JSONDecoder().decode([User].self, from: data) {
                user = decoded
            }
        }
    }
}

struct User: Codable {
    var _id, id, firstName, lastName, username, password, date: String
    
    init() {
        self._id = ""
        self.id = ""
        self.firstName = ""
        self.lastName = ""
        self.username = ""
        self.password = ""
        self.date = ""
    }
}

func LoginTile(_ width: CGFloat, _ height: CGFloat, _ background: Color) -> some View {
    ZStack {
        Text("")
            .multilineTextAlignment(.leading)
            .frame(width: width, height: height)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 10, x: 6, y: 4)
    }
}

func tile(_ width: CGFloat, _ height: CGFloat, _ background: Color) -> some View {
    ZStack {
        Text("")
            .multilineTextAlignment(.leading)
            .frame(width: width, height: height)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 10, x: 6, y: 4)
    }
}

func circleTile(_ width: CGFloat, _ height: CGFloat, _ background: Color) -> some View {
    ZStack {
        Text("")
            .multilineTextAlignment(.leading)
            .frame(width: width, height: height)
            .background(background)
            .clipShape(Circle())
            .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 10, x: 6, y: 4)
    }
}
