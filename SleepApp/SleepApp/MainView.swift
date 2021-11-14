//
//  MainView.swift
//  SleepApp
//
//  Created by Jonathan Pang on 11/13/21.
//

import SwiftUI

struct LineChartView: View {
    let values: [Int]
    let labels: [String]
    
    let screenWidth = UIScreen.main.bounds.width
    
    private var path: Path {
        if values.isEmpty {
            return Path()
        }
        
        var offsetX: Int = Int(screenWidth/CGFloat(values.count * 2))
        var path = Path()
        path.move(to: CGPoint(x: offsetX, y: values[0]))
        
        for value in 1..<values.count {
            offsetX += Int(screenWidth/CGFloat(values.count))
            path.addLine(to: CGPoint(x: offsetX, y: values[value]))
        }
        
        return path
    }
    
    
    var body: some View {
        path.stroke(CGFloat(values[1]) > CGFloat(values[0]) ? Color.red: Color.green, lineWidth: 2)
    }
}
struct MainView: View {
    @State var average: String = ""
    @State var numericAvg: CGFloat = 0
    @State var tapped: Bool = false
    @State var value: Double = 0
    @State var hours: String = "0"
    @State var mins: String = "0"
    @ObservedObject var status = NotificationStatus()
    var data = [200, 60, 70, 20, 0, 150, 200]
    var xAxis = ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7"]
    
    func instantNotif() {
        if status.status.status == "ON" {
            let content = UNMutableNotificationContent()
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            content.title = "Sleep Warning"
            content.subtitle = "Go back to sleep!"
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                    UNUserNotificationCenter.current().add(request)
                }
                else {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            UNUserNotificationCenter.current().add(request)
                        }
                    }
                }
                UNUserNotificationCenter.current().add(request)
            }
        }
        else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    func setNotification() {
        if status.status.status == "ON" {
            let content = UNMutableNotificationContent()
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            content.title = "Sleep Warning"
            content.subtitle = "Time to wake up!"
            content.sound = UNNotificationSound.default
            if (Int(hours)! == 0 && Int(mins)! == 0) {
                return
            }
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(Int(hours)! * 60 + Int(mins)!), repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized {
                    UNUserNotificationCenter.current().add(request)
                }
                else {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            UNUserNotificationCenter.current().add(request)
                        }
                    }
                }
                UNUserNotificationCenter.current().add(request)
            }
        }
        else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    func setAvg() {
        var sum: CGFloat = 0
        for i in data {
            sum += CGFloat(8 * (Double(i) / 120))
        }
        
        sum /= CGFloat(data.count)
        sum = CGFloat(round(1000*sum)/1000)
        numericAvg = sum
        
        average = "\(sum) hrs"
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Average amount of sleep per day: \(average)")
                    .font(.title3)
            }
            .frame(height: UIScreen.main.bounds.width / 32)
            .padding(.bottom)
            
            if numericAvg < 8 && numericAvg != 0 {
                VStack {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .padding(.leading)
                            .font(.title)
                        Spacer()
                        Text("You have below the necessary amount of sleep per day!")
                            .padding(.trailing)
                            .offset(x: -1 * UIScreen.main.bounds.width / 16)
                    }
                    .foregroundColor(Color.red)
                    .padding(.bottom)
                    
                    HStack {
                        Text("It is recommended to have at least 8 hours of sleep per day.")
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Please try to get that next week!")
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        Spacer()
                    }
                }
            }
            
            else if (tapped) {
                VStack {
                    HStack {
                        Image(systemName: "checkmark.circle")
                            .padding(.leading)
                            .padding(.trailing, UIScreen.main.bounds.width / 128 * 5)
                            .font(.title)
                            
                        Spacer()
                        Text("You have more than the necessary amount of sleep per day!")
                            .padding(.trailing)
                            .offset(x: -1 * UIScreen.main.bounds.width / 16)
                    }
                    .foregroundColor(Color.green)
                    .padding(.bottom)
                    
                    HStack {
                        Text("It is recommended to have at least 8 hours of sleep per day.")
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Good job! Get even more sleep next week!")
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        Spacer()
                    }
                }
            }
            
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        ZStack {
                            tile(UIScreen.main.bounds.width / 8 * 3, UIScreen.main.bounds.height / 32, Color.white)
                            Text("Sleeping Trends: ")
                                
                        }
                        .padding(.leading)
                        Spacer()
                    }
                }
                .offset(y: -1 * UIScreen.main.bounds.height / 32 * 9)
                
                VStack {
                    LineChartView(values: data, labels: xAxis)
                        .padding(.trailing)
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    HStack {
                        ForEach(xAxis, id: \.self) { label in
                            Text(label)
                                .frame(width: UIScreen.main.bounds.width/CGFloat(data.count) - 10)
                        }
                    }
                }
                
            }
            
            HStack {
                ZStack {
                    circleTile(100, 100, Color.white)
                    Circle()
                        .fill(Color.teal)
                        .frame(width: 100, height: 100)
                        .onLongPressGesture {
                            withAnimation(.easeInOut(duration: 1)) {
                                tapped = true
                                if (value == 0) {
                                    value = 1
                                }
                             setAvg()
                            }
                        }
                    
                    Circle()
                        .trim(from: 0, to: value)
                        .stroke(AngularGradient(gradient: Gradient(colors: [Color.black]),
                                                center: .center,
                                                startAngle: .degrees(0),
                                                endAngle: .degrees(360)
                                            ),
                                            style: StrokeStyle(lineWidth: 2, lineCap: .round)
                        )
                        .rotationEffect(Angle(degrees: 180))
                        .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 1, z: 0))
                        .frame(width: 100, height: 100)
                    Text("Calculate")

                }
                
            }
            .padding(.bottom, UIScreen.main.bounds.height / 16)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            instantNotif()
        }
    }
    
}

extension Color {
    static let teal = Color(red: 49 / 255, green: 163 / 255, blue: 255 / 255)
    static let darkPink = Color(red: 208 / 255, green: 45 / 255, blue: 208 / 255)
}
