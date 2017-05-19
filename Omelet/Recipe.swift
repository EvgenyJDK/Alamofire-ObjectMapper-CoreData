//
//  Recipe.swift
//  Omelet
//
//  Created by Administrator on 27.03.17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreData


class  Recipe : Mappable {
    
    var title : String?
    var description : String?
    var imageURL : String?
    var href : String?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {

        title <- map["title"]
        description <- map["ingredients"]
        imageURL <- map["thumbnail"]
        href <- map["href"]
        
    }

}

