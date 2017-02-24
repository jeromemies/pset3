//
//  SecondViewController.swift
//  jeromemies-pset3
//
//  Created by Jerome Mies on 24/02/17.
//  Copyright © 2017 Jerome Mies. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var data:String?
    
    @IBOutlet weak var outputTable: UITableView!
    
    //@IBOutlet weak var savedItem: CustomCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(data)
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

extension SecondViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (data != nil){
            return 1
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let secondCell = self.outputTable.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! CustomCell;
        if let labels = data {
            secondCell.savedList?.text = labels
        } else {
            
        }
        return secondCell
        
        
    }
    
}

extension SecondViewController: UITableViewDelegate{
    
}
