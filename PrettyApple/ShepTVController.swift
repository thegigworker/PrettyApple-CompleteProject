//
// shepProductsTVController.swift
//
//  xAppleProductsTableViewController.swift
//  Created by Duc Tran on 3/28/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

import UIKit

/*  NOTE RE THIS SYSTEM ERROR:  this class is not key value coding-compliant for the key XXX.'
 Another common cause if you are using Storyboard, your UIButton might have more then one assignings, a wrong Outlet or Action or an extra one.
 Open your storyboard and right click the XXX
 You will see that there is more than one assign/ref to this XXX. Remove one of the "Main..." greyed windows with the small "x":
 */

/* To display dynamic data, a table view needs two important helpers: a data source and a delegate. A table view data source, as implied by its name, supplies the table view with the data it needs to display. A table view delegate helps the table view manage cell selection, row heights, and other aspects related to displaying the data. By default, UITableViewController and its subclasses adopt the necessary protocols to make the table view controller both a data source (UITableViewDataSource protocol) and a delegate (UITableViewDelegate protocol) for its associated table view. Your job is to implement the appropriate protocol methods in your table view controller subclass so that your table view has the correct behavior.
 
 // A functioning table view requires three table view data source methods.
 func numberOfSections(in tableView: UITableView) -> Int
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
 */

////////////////////
//The final step to displaying data in the user interface is to connect the code defined in shepProductsTVController.swift to the Shep TableView Scene.
//In the Identity inspector, find the field labeled Class, and select shepProductsTVController.
///////////////////

class ShepTVController: UITableViewController {
    
    //MARK: Properties
    

    lazy var BigKahunaSectionedArray: [allSectionsOfData4TVC] = {
        // I don't get all the syntax here, but the concept is: line above declares as an array of sectionOfProducts_class
        // then in line below, populates this array by using sectionOfProducts_class.getAllTheSections method
        //let temp = allSectionsOfData4TVC
        return allSectionsOfData4TVC.getAllTheSections()
    }()
    
    // This code declares a property on ShepTableViewController and initializes it with a default value (an empty array of ShepSingleItem objects)
    // var meals = [Meal]()
    //var ShepItems = [ShepSingleXYZ]()
    
    
    // MARK: - VC Lifecycle
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this one line of code automatically provides all kinds of UI Edit functionality.
        // editButtonItem only available w UITableViewController
        // actual edit funtionality in func:  commit editingStyle: UITableViewCellEditingStyle
        navigationItem.rightBarButtonItem = editButtonItem
        
//        // Make the row height dynamic
//        tableView.estimatedRowHeight = tableView.rowHeight
//        //tableView.estimatedRowHeight = 185.0
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentSize.height = 150
        
        // --------------------------------------------------------------------------
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //The template implementation of this method includes comments that were inserted by Xcode when it created MealTableViewController.swift. Code comments like this provide helpful hints and contextual information in source code files, but you don’t need them for this lesson.
        // --------------------------------------------------------------------------

       // loadSampleMeals()  // Load the sample data.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
 
    // MARK: - ForHeaderInSection
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // CREATE HEADER CELL VIA STORYBOARD PROTOTYPE CELL & CUSTOM UITableViewCell CLASS
        let headerInSectionCell = tableView.dequeueReusableCell(withIdentifier: "HeaderInSectionTVCell") as! HeaderInSectionTVCell
        // let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTVCell \(section)") as! headerTVCell
        // // Can add section number to cell identifier name in order to differentiate between a series of different section header cells
        // // such as HeaderTVCell0, HeaderTVCell1, HeaderTVCell2, etc.
        
        // WAY TO SET PROPERTIES RIGHT HERE: headerCell.lblCategory.text =  BigKahunaSectionedArray[section].sectionName
        let labelText = BigKahunaSectionedArray[section].sectionName    // sectionTitles[section]
        headerInSectionCell.configureCellWith(labelText: "---  " + labelText + "  ---") // (labelText: String, image: UIImage) etc.
        return headerInSectionCell
        
        // CREATE HEADER CELL VIA CODE
        //let view = UIView()
        //view.backgroundColor = UIColor.orange
        // let image = UIImageView(image: sectionImages[section])  // BigKahunaSectionedArray[section].sectionImages
        // image.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        // view.addSubview(image)
        // let label = UILabel()
        // label.text = BigKahunaSectionedArray[section].sectionName  // sectionTitles[section]
        // label.frame = CGRect(x: 40, y: 5, width: 150, height: 25)
        //view.addSubview(label)
        //return view
    }
    
    // don't even need this function at all if using viewForHeaderInSection
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let productLine = BigKahunaSectionedArray[section]
//        return productLine.sectionName
//    }
 
    
   // MARK: - Table view data source methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return BigKahunaSectionedArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let productLine = BigKahunaSectionedArray[section]
        return productLine.oneSectionOfData.count   // the number of products in the section
        //productLine.oneSectionOfData
    }

    // indexPath: which section and which row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Because you created a custom cell class that you want to use, downcast the type of the cell to your custom cell subclass, shepOrigProductTVCell.
        //let cell = tableView.dequeueReusableCell(withIdentifier: "shepOrigProductTVCell", for: indexPath) as! shepOrigProductTVCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShepTableViewCell", for: indexPath) as! ShepTableViewCell
        let productLine = BigKahunaSectionedArray[indexPath.section]
        let product = productLine.oneSectionOfData[indexPath.row]

        cell.setupCell(product)
        
        return cell
    }
    /*
     The last data source method, tableView(_:cellForRowAt:), configures and provides a cell to display for a given row. Each row in a table view has one cell, and that cell determines the content that appears in that row and how that content is laid out.
     
     For table views with a small number of rows, all rows may be onscreen at once, so this method gets called for each row in your table. But table views with a large number of rows display only a small fraction of their total items at a given time. It’s most efficient for table views to ask for only the cells for rows that are being displayed, and that’s what tableView(_:cellForRowAt:) allows the table view to do.
     */
    
    
   // MARK:  Delegate Methods
    
   /*
    optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     // Instance Method. Tells the delegate that the specified row is now selected.
    Parameters
    tableView --A table-view object informing the delegate about the new row selection.
    indexPath --An index path locating the new selected row in tableView.
     The delegate handles selections in this method. One of the things it can do is exclusively assign the check-mark image (checkmark) to one row in a section (radio-list style).
     This method isn’t called when the isEditing property of the table is set to true (that is, the table view is in editing mode).
     See "Managing Selections" in Table View Programming Guide for iOS for further information (and code examples) related to this method.
     SHEP'S NOTE: Good place to put performSegue(withIdentifier code
   */
    
    // MARK: - Edit Tableview
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            var productLine = BigKahunaSectionedArray[indexPath.section]
            productLine.oneSectionOfData.remove(at: indexPath.row)
            // tell the table view to update with new data source
            // tableView.reloadData()    Bad way!
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            // Note that there are many other types of UITableViewRowAnimation possible
            /*
             if editingStyle == .delete {
             // Delete the row from the data source
             tableView.deleteRows(at: [indexPath], with: .fade)
             } else if editingStyle == .insert {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
             }
             */
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */

    
    // MARK: - Moving Cells
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let productToMove = BigKahunaSectionedArray[sourceIndexPath.section].oneSectionOfData[sourceIndexPath.row]
        
        // move productToMove to destinationIndexPath
        BigKahunaSectionedArray[destinationIndexPath.section].oneSectionOfData.insert(productToMove, at: destinationIndexPath.row)
        
        // delete the productToMove from sourceIndexPath
        BigKahunaSectionedArray[sourceIndexPath.section].oneSectionOfData.remove(at: sourceIndexPath.row)
    }

    
    // MARK: - Navigation / Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        // The UIViewController class’s implementation doesn’t do anything, but it’s a good habit to always call super.prepare(for:sender:) whenever you override prepare(for:sender:). That way you won’t forget it when you subclass a different class.
        
        if let identifier = segue.identifier {
            switch identifier {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
            case "Second Detail View":
                let productDetailVC = segue.destination as! shepSecondDetailVC
                if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell) {
                        productDetailVC.product = productAtIndexPath(indexPath)
                    }
                case "Show Editable Detail":
                    let editTableVC = segue.destination as! shepEditableDetailVC
                    if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell) {
                        editTableVC.shepProductDetail = productAtIndexPath(indexPath)
                    }
                
                default: break
            }
        }
    }
    
    // MARK: - Helper Method
    
    func productAtIndexPath(_ indexPath: IndexPath) -> ShepSingleXYZ
    {
        let productLine = BigKahunaSectionedArray[indexPath.section]
        return productLine.oneSectionOfData[indexPath.row]
    }
    
    //MARK: Private Methods
  //  private func loadSampleMeals() {
        
        //        let photo1 = UIImage(named: "meal1")
        //        let photo2 = UIImage(named: "meal2")
        //        let photo3 = UIImage(named: "meal3")
        
        //  Because the Meal class’s init!(name:, photo:, rating:) initializer is failable, you need to check the result returned by the initializer. In this case, you are passing valid parameters, so the initializer should never fail. If the initializer does fail, you have a bug in your code. To help you identify and fix any bugs, if the initializer does fail, the fatalError() function prints the error message to the console and the app terminates.
        
        //        guard let meal1 = ShepSingleXYZ(name: "Caprese Salad", photo: photo1, rating: 4) else {
        //            fatalError("Unable to instantiate meal1")
        //        }
        //
        //        guard let meal2 = ShepSingleXYZ(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
        //            fatalError("Unable to instantiate meal2")
        //        }
        //
        //        guard let meal3 = ShepSingleXYZ(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
        //            fatalError("Unable to instantiate meal2")
        //        }
        //
        //        // note the way that this array gets built below
        //        ShepItems += [meal1, meal2, meal3]
  //  }
    
    
    //THIS IS A PLACEHOLDER FOR AN ALTERNATIVE cellForRowAt indexPath
    //WITH COMMENTS AND AN INTERESTING GUARD STATEMENT
    func xtableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        // To make this code work for your app, you’ll need to change the identifier to the prototype cell identifier you set in the storyboard (MealTableViewCell), and then add code to configure the cell.
        
        let cellIdentifier = "shepOrigProductTVCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? shepOrigProductTVCell  else {
            fatalError("The dequeued cell is not an instance of shepOrigProductTVCell.")
        }
        /* There’s a lot going on in this code:
         The as? shepOrigProductTVCell expression attempts to downcast the returned object from the UITableViewCell class to your shepOrigProductTVCell class. This returns an optional.
         The guard let expression safely unwraps the optional.
         If your storyboard is set up correctly, and the cellIdentifier matches the identifier from your storyboard, then the downcast should never fail. If the downcast does fail, the fatalError() function prints an error message to the console and terminates the app.
         */
        
        return cell
    }
    
}


// MARK: UNWIND SEGUE
//
//  The next step in creating the unwind segue is to add an action method to the destination view controller (the view controller that the segue is going to). This method must be marked with the IBAction attribute and take a segue (UIStoryboardSegue) as a parameter. Because you want to unwind back to the meal list scene, you need to add an action method with this format to MealTableViewController.swift.
//  In this method, you’ll write the logic to add the new meal (that’s passed from MealViewController, the source view controller) to the meal list data and add a new row to the table view in the meal list scene.

/* Now, when users tap the Save button, they navigate back to the meal list scene, during which process the unwindToMealList(sender:) action method is called.
 EXPLORE FURTHER
 Unwind segues provide a simple method for passing information back to an earlier view controller. Sometimes, however, you need more complex communication between your view controllers. In those cases, consider using the DELEGATE pattern.  See Delegation in The Swift Programming Language (Swift 4.0.3).
 */

//    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
//
////            There’s a lot happening in the condition for this if statement.
////            This code uses the optional type cast operator (as?) to try to downcast the segue’s source view controller to a MealViewController instance. You need to downcast because sender.sourceViewController is of type UIViewController, but you need to work with a MealViewController.
////            The operator returns an optional value, which will be nil if the downcast wasn’t possible. If the downcast succeeds, the code assigns the MealViewController instance to the local constant sourceViewController, and checks to see if the meal property on sourceViewController is nil. If the meal property is non-nil, the code assigns the value of that property to the local constant meal and executes the if statement.
////            If either the downcast fails or the meal property on sourceViewController is nil, the condition evaluates to false and the if statement doesn’t get executed.
//
//        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
//
//            // Add a new meal.
//            let newIndexPath = IndexPath(row: ShepItems.count, section: 0)
//           // This code computes the location in the table view where the new table view cell representing the new meal will be inserted, and stores it in a local constant called newIndexPath.
//
//           // meals.append(meal)
//           // ShepItems.append(meal) // THIS LINE NEEDS TO BE FIXED, ShepItems can't work with "meals"
//
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//            // This animates the addition of a new row to the table view for the cell that contains information about the new meal. The .automatic animation option uses the best animation based on the table’s current state, and the insertion point’s location.
//        }
//    }




































