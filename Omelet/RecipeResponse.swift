//
//  RecipeResponse.swift
//  Omelet
//
//  Created by Administrator on 27.03.17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import Foundation
import ObjectMapper


class  RecipeResponse: Mappable {

    var recipes : [Recipe]?

    required init? (_ map : Map){
    }

    func mapping(map : Map) {
        recipes <- map["results"]
    }

}