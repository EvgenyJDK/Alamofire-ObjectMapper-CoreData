//
//  CoreDataService.swift
//  Omelet
//
//  Created by Administrator on 27.03.17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SDWebImage

class  CoreDataService {
    
    var recipeList = [NSManagedObject]()

    
    func saveRecipe (recipeEntities : [Recipe]) {
        
        for recEnt in recipeEntities {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let entity = NSEntityDescription.entityForName("RecipeEntity", inManagedObjectContext: managedContext)
            let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)

            var dublicateRecipe = false
            
            if (recipeList.count > 0) {
                for recList in recipeList {
                    if (recEnt.href == recList.valueForKey("recipeHref") as? String) {
                        dublicateRecipe = true
                    }
                }
            }
            
            item.setValue(recEnt.title, forKey: "recipeTitle")
            item.setValue(recEnt.description, forKey: "recipeDescription")
            item.setValue(recEnt.href, forKey: "recipeHref")
            
            let urlString  = NSURL(string: recEnt.imageURL!)
            let data = NSData(contentsOfURL: urlString!)
            item.setValue(data, forKey: "recipeImage")
            
            if (!dublicateRecipe) {
                do {
                    try managedContext.save()
                    recipeList.append(item)
                    print("saved to CD")
                }
                catch {
                    print("Error! Can't save to CD")
                }
            }
        }
    }

    
    func fetchRecipe() -> [NSManagedObject] {

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "RecipeEntity")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            recipeList = results as! [NSManagedObject]
        }
        catch {
            print("error fetch")
        }
       return recipeList
    }

}