//
//  IntentHandler.swift
//  SpacePhotoIntent
//
//  Created by Peter Minarik on 04.07.18.
//  Copyright © 2018 Peter Minarik. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
  
  override func handler(for intent: INIntent) -> Any {
    guard intent is PhotoOfTheDayIntent else {
      fatalError("Unhandled intent type: \(intent)")
    }
    
    return PhotoOfTheDayIntentHandler()
  }
  
}
