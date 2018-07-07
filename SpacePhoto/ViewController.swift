//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Peter Minarik on 01.07.18.
//  Copyright © 2018 Peter Minarik. All rights reserved.
//

import UIKit
import Intents
import os.log

class ViewController: UIViewController {
  
  
  @IBOutlet weak var imageVIew: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    let photoInfoController = PhotoInfoController()
    photoInfoController.fetchPhotoOfTheDay { (photoInfo) in
      if let photoInfo = photoInfo {
        self.updateUI(with: photoInfo)
      }
    }
    
    donateInteraction()
  }
  
  func donateInteraction() {
    let intent = PhotoOfTheDayIntent()
    
    intent.suggestedInvocationPhrase = "Energize"
    
    let interaction = INInteraction(intent: intent, response: nil)
    
    interaction.donate { (error) in
      if error != nil {
        if let error = error as NSError? {
          os_log("Interaction donation failed: %@", log: OSLog.default, type: .error, error)
        } else {
          os_log("Successfully donated interaction")
        }
      }
    }
  }
  
  func updateUI(with photoInfo: PhotoInfo) {
    let photoInfoController = PhotoInfoController()
    photoInfoController.fetchUrlData(with: photoInfo.url) { (data) in
      guard
        let data = data,
        let image = UIImage(data: data)
      else {
        return
      }
      
      DispatchQueue.main.async {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        self.title = photoInfo.title
        self.imageVIew.image = image
      }
      
    }
  }

}

