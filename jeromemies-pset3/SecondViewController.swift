//
//  SecondViewController.swift
//  jeromemies-pset3
//
//  Created by Jerome Mies on 24/02/17.
//  Copyright © 2017 Jerome Mies. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var data:String!
    var favorites: Array<String>?
    
    @IBOutlet weak var outputTable: UITableView!
    
    //@IBOutlet weak var savedItem: CustomCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputTable.delegate = self
        outputTable.dataSource = self
        // Do any additional setup after loading the view.
        self.favorites = UserDefaults.standard.array(forKey: "list") as? [String] ?? []
        
        self.favorites!.append(data)
        UserDefaults.standard.set(self.favorites!, forKey: "list")
        //print(favorites)
        //print(data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SecondViewController: UITableViewDataSource {
    func numberOfRowsInSectionsinTableView(tableView: UITableView) -> Int {
        //print(data)
            return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.favorites?.count)!
    }

        
//        if (data != nil){
//            print(favorites!.count)
//            return favorites!.count
//            
//        } else {
//            return 0
//        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let secondCell = self.outputTable.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondCustomCell;
        self.favorites = UserDefaults.standard.array(forKey: "list") as? [String] ?? []
        let labels = self.favorites
            print(self.favorites)
            //print(labels)
            secondCell.savedList.text = self.favorites?[indexPath.row]
        
        return secondCell;
        
        
    }
    
}

extension SecondViewController: UITableViewDelegate{
    
}
