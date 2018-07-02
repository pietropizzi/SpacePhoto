//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Peter Minarik on 01.07.18.
//  Copyright © 2018 Peter Minarik. All rights reserved.
//

import UIKit

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
  }
  
  func updateUI(with photoInfo: PhotoInfo) {
    fetchImage(with: photoInfo.url) { (image) in
      DispatchQueue.main.async {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        self.title = photoInfo.title
        self.imageVIew.image = image
      }
      
    }
  }
  
  func fetchImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if
        let data = data,
        let image = UIImage(data: data)
      {
        completion(image)
      } else {
        completion(nil)
      }
    }
   
    task.resume()
  }

}

