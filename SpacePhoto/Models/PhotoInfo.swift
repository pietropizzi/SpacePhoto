//
//  PhotoInfo.swift
//  SpacePhoto
//
//  Created by Peter Minarik on 01.07.18.
//  Copyright © 2018 Peter Minarik. All rights reserved.
//

import Foundation

struct PhotoInfo: Codable {
  
  var title: String
  var description: String
  var url: URL
  var copyright: String?
  
  enum Keys: String, CodingKey {
    case title
    case description = "explanation"
    case url
    case copyright
  }
  
  init(from decoder: Decoder) throws {
    let valueContainer = try decoder.container(keyedBy: Keys.self)
    
    self.title = try valueContainer.decode(String.self, forKey: Keys.title)
    self.description = try valueContainer.decode(String.self, forKey: Keys.description)
    self.url = try valueContainer.decode(URL.self, forKey: Keys.url)
    self.copyright = try? valueContainer.decode(String.self, forKey: Keys.copyright)
  }
  
}
