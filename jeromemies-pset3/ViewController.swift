//
//  ViewController.swift
//  jeromemies-pset3
//
//  Created by Jerome Mies on 24/02/17.
//  Copyright © 2017 Jerome Mies. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    
    var selectedData: String = ""
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    var searchActive : Bool = false
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.   
        /* Setup delegates */
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        
        let url = URL(string:"https://www.omdbapi.com/?")!
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in // ...
            print(String(data: data!, encoding: .utf8))
        }
        task.resume()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //story.fillInPlaceholder(word: "job")
        
        
        let secondViewController = segue.destination as! SecondViewController
        
        // Closure
        secondViewController.data = self.selectedData
        print(self.selectedData)

    }
    
}

extension ViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        searchActive = false;
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableview.reloadData()
        
    }
}


extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell;
        if(searchActive){
            cell.filteredCell?.text = filtered[indexPath.row]
        } else {
            cell.filteredCell?.text = data[indexPath.row];
        }
        
        return cell;
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if (filtered.count == data.count){
        self.selectedData = data[indexPath.row]
        } else {
            self.selectedData = filtered[indexPath.row]
        }
        
    }
}

