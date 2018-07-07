//
//  IntentViewController.swift
//  IntentUI
//
//  Created by Peter Minarik on 03.07.18.
//  Copyright © 2018 Peter Minarik. All rights reserved.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - INUIHostedViewControlling
  
  // Prepare your view controller for the interaction to handle.
  func configureView(for parameters: Set<INParameter>,
                     of interaction: INInteraction,
                     interactiveBehavior: INUIInteractiveBehavior,
                     context: INUIHostedViewContext,
                     completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
    
    guard interaction.intent is PhotoOfTheDayIntent else {
      completion(false, Set(), .zero)
      return
    }
    
    let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
    let desiredSize = CGSize(width: width, height: 300)
    
    activityIndicator.startAnimating()
    
    let photoInfoController = PhotoInfoController()
    photoInfoController.fetchPhotoOfTheDay { (photoInfo) in
      if let photoInfo = photoInfo {
        photoInfoController.fetchUrlData(with: photoInfo.url) { [weak self] (data) in
          if let data = data {
            let image = UIImage(data: data)!
            
            DispatchQueue.main.async {
              self?.imageView.image = image
              self?.activityIndicator.stopAnimating()
              self?.activityIndicator.isHidden = true
            }
          }
        }
      }
    }
    
    completion(true, parameters, desiredSize)
  }
  
}
