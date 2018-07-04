//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Peter Minarik on 01.07.18.
//  Copyright © 2018 Peter Minarik. All rights reserved.
//

import Foundation

struct PhotoInfoController {
  
  let baseURL = URL(string: "https://api.nasa.gov")!
  
  let queryParams = [
    "api_key": "DEMO_KEY"
  ]
  
  func fetchPhotoOfTheDay(completion: @escaping (PhotoInfo?) -> Void) {
    let url = baseURL
      .appendingPathComponent("planetary")
      .appendingPathComponent("apod")
      .withQueries(queryParams)!
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      let jsonDecoder = JSONDecoder()
      if
        let data = data,
        let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data)
      {
        completion(photoInfo)
      } else {
        completion(nil)
      }
    }
    
    task.resume()
  }
  
  func fetchUrlData(with url: URL, completion: @escaping (Data?) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data {
        completion(data)
      } else {
        completion(nil)
      }
    }
    
    task.resume()
  }
  
}
