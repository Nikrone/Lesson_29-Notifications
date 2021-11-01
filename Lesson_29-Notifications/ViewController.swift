//
//  ViewController.swift
//  Lesson_29-Notifications
//
//  Created by Evgeniy Nosko on 1.11.21.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        
//чтобы нотификации шли, когда приложение активно
        center.delegate = self
    }
    
    @IBAction func createNotification() {
        
        //        Создание локальной нотификации
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
//        создание кнопки в нотификации
//        можем создавать больше одной кнопки (должны быть разные - identifier)
        let action = UNNotificationAction(identifier: "123", title: "Start", options: .foreground, icon: nil)
        let text = UNTextInputNotificationAction(identifier: "12", title: "Start2", options: .foreground, icon: nil, textInputButtonTitle: "go", textInputPlaceholder: "placeholder")
        let category = UNNotificationCategory(identifier: "alarm", actions: [action, text], intentIdentifiers: ["12345"], options: .allowInCarPlay)
        center.setNotificationCategories([category])
        
        
        var date = DateComponents()
        date.hour = 21
        date.minute = 04
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
}

// чтобы нотификации шли, когда приложение активно
extension ViewController: UNUserNotificationCenterDelegate {

//    отлавливает действия с нотификацией
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.content.userInfo)
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    
    
}

