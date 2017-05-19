//
//  RecipeViewController.swift
//  Omelet
//
//  Created by Administrator on 27.03.17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import CoreData

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {

    @IBOutlet weak var searchRecipe: UISearchBar!
    @IBOutlet weak var recipesTableView: UITableView!
    
    @IBOutlet weak var recipeWEBView: UIWebView!
  
    let apiService = ApiService ()
    let coreDataService = CoreDataService ()
    var recipe : [Recipe] = []
     
    var recipeListContr = [NSManagedObject]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchRecipe.delegate = self
        
        getPersistentData()

        apiService.getRecipeByDefault { (response, error) in
            if (response != nil) {
                self.recipe = (response?.recipes)!
            }
            self.coreDataService.saveRecipe(self.recipe) // After this method +++++++
            self.getPersistentData()
            self.recipesTableView.reloadData()
        }
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeListContr.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let recipeCell = recipesTableView.dequeueReusableCellWithIdentifier("recipeCell", forIndexPath: indexPath) as! RecipeTableCell
        recipeCell.recipeTitle.text = ((self.recipeListContr[indexPath.row].valueForKey("recipeTitle")) as! String)
        recipeCell.recipeDescription.text = ((self.recipeListContr[indexPath.row].valueForKey("recipeDescription")) as! String)
        recipeCell.recipeDescription.editable = false
        
        if let data = ((self.recipeListContr[indexPath.row].valueForKey("recipeImage")) as? NSData) {
            let img = UIImage(data: data)
            recipeCell.recipeImage.image = img
            recipeCell.recipeImage.setRounded()
        }
        return recipeCell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        if let recipeCell = tableView.cellForRowAtIndexPath(indexPath) as? RecipeTableCell {
            
            let recipeURL = NSURL (string: (self.coreDataService.fetchRecipe()[indexPath.row].valueForKey("recipeHref") as! String))
            let requestObj = NSURLRequest(URL: recipeURL!)
            self.recipeWEBView.loadRequest(requestObj)
        }
    }
   
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        apiService.getRecipeOnDemand(searchText) { (response, error) in
          
            if (response != nil) {
                self.recipe = (response?.recipes)!
                self.coreDataService.saveRecipe((response?.recipes)!)
            }
            self.recipeListContr = self.coreDataService.fetchRecipe()
            self.recipesTableView.reloadData()
        }
    }
  
    
    func getPersistentData() {
        self.recipeListContr = self.coreDataService.fetchRecipe()
     }
}


extension UIImageView {
    
    func setRounded() {
        let radius = CGRectGetWidth(self.frame) / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.backgroundColor = UIColor.whiteColor().CGColor
    }
}

