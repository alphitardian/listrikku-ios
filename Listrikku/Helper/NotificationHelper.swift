//
//  NotificationHelper.swift
//  Listrikku
//
//  Created by Ardian Pramudya Alphita on 07/05/22.
//

import Foundation
import UserNotifications

class NotificationHelper {
    
    static func registerReminder() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("notification granted")
            } else {
                print("notification not granted")
            }
        }
    }
    
    static func scheduleReminder(date: Date, customMessage: String) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Listrikku Notification"
        content.body = customMessage.isEmpty ? "Yuk jangan lupa bayar tagihanmu!" : customMessage
        content.sound = .default
        
        let userDate = date.get(.year, .day, .month)
        let dateComponent = DateComponents(year: userDate.year, month: userDate.month, day: userDate.day, hour: 8, minute: 0)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)   // Use real date
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // For testing purpose
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
}
