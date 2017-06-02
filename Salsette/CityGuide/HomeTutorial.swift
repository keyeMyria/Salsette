//
//  Salsette
//
//  Created by Marton Kerekes on 22/03/2017.
//  Copyright © 2017 Marton Kerekes. All rights reserved.
//

import UIKit

struct HomeTutorial: ContentEntityInterface {
    var name: String?
    var image: UIImage?
    var shortDescription: String
    var description: String
    
    var organiser: String? { get { return nil }}
    var startDate: Date? { get { return nil }}
    var endDate: Date? { get { return nil }}
    var location: String? { get { return nil }}
    var type: EventTypes? { get { return nil }}
    
    static var cards: [ContentEntityInterface] {
        get {
            didShow = true
            return [
                HomeTutorial(name: "Welcome to Salsette.",
                             image: #imageLiteral(resourceName: "vancouver"),
                             shortDescription: "Tap me!",
                             description: "Thank you for installing. Here you can have a look at dance events you searched for."),
                HomeTutorial(name: "Take your time, look around.",
                             image: #imageLiteral(resourceName: "toronto"),
                             shortDescription: "Your guide to the next dance class or party.",
                             description: "Try changing some of the wording above.. search for the type of dance, name, location or dates."),
                HomeTutorial(name: "Share it.",
                             image: #imageLiteral(resourceName: "montreal"),
                             shortDescription: "Log in and share your own events.",
                             description: "By logging in with your facebook account, you can import and customize your dance events. What is the schedule? Which workshops will you offer?")
            ]
        }
    }
    
    static var didShow: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "didShowHomeTutorial")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "didShowHomeTutorial")
        }
    }
}