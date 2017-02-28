//
//  SecondViewController.swift
//  jeromemies-pset3
//
//  Created by Jerome Mies on 24/02/17.
//  Copyright © 2017 Jerome Mies. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var data: [String: String]? {
        didSet {
            guard let data = data else { return }
            
            self.favorites.append(data)
        }
    }
    var favorites: [[String: String]] = UserDefaults.standard.array(forKey: "list") as? [[String: String]] ?? []
    
    @IBOutlet weak var outputTable: UITableView!
    
    //@IBOutlet weak var savedItem: CustomCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputTable.delegate = self
        outputTable.dataSource = self
        // Do any additional setup after loading the view.
        
        UserDefaults.standard.set(self.favorites, forKey: "list")
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
        return (self.favorites.count)
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
        
        
            //print(labels)
            secondCell.savedList.text = self.favorites[indexPath.row]["Title"]
        secondCell.savedListYear.text = self.favorites[indexPath.row]["Year"]
        
        return secondCell;
        
        
    }
    
}

extension SecondViewController: UITableViewDelegate{
    
}
