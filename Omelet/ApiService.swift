//
//  ApiService.swift
//  Omelet
//
//  Created by Administrator on 27.03.17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import CoreData


class  ApiService: UITableViewController {
    
    let defaultURL = "http://www.recipepuppy.com/api/?i=onions,garlic&q=omelet&p=3"
    var searchURL : String = ""
    
    
    func getRecipeByDefault (callback: (RecipeResponse?, ApiError?) -> Void) {
        
        Alamofire.request(.GET, defaultURL).responseObject {(response : Response<RecipeResponse, NSError>) in
            
            let recipeResponse = response.result.value
            print ("ALAMOFIRE RESPONSE COUNT = \(recipeResponse?.recipes?.count)")
            callback(recipeResponse, nil)
        }
    }

    
    func getRecipeOnDemand (inputData: String, callback: (RecipeResponse?, ApiError?) -> Void) {
        
        if (inputData == "") {
            searchURL = defaultURL
        } else {
            searchURL = "http://www.recipepuppy.com/api/?q=" + inputData
        }
        
        Alamofire.request(.GET, searchURL).responseObject { (response:Response<RecipeResponse, NSError>) in
            let searchRecipeResponse = response.result.value
            callback(searchRecipeResponse, nil)
        }
    }
   
}