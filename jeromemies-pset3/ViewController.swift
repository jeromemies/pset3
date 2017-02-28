//
//  ViewController.swift
//  jeromemies-pset3
//
//  Created by Jerome Mies on 24/02/17.
//  Copyright © 2017 Jerome Mies. All rights reserved.
//

import UIKit
import Foundation

//class Movie {
//    
//    var movie: Dictionary<String, Any>
//    
//
//        
//    
//    
//    
//}


class ViewController: UIViewController {

    
    var selectedData: [String : String]?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    
    var searchActive : Bool = false
    var data:[[String : String]] = []
    var filtered:[[String : String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.   
        /* Setup delegates */
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        tableview.rowHeight = 85
        let i = "hello"
        let year = ""
        let url = URL(string:"https://www.omdbapi.com/?t=" + i + "&y=" + year + "&plot=short&r=json")!
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in // ...
            //let selectedData = String(data: data!, encoding: .utf8)
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            print(json)
            if let dictionary = json as? [String: Any] {
                let title = dictionary["Title"] as? String
                
                self.data.append(dictionary as! [String : String])
                
            }
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
        secondViewController.data = self.selectedData!
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
        
        var title: String = ""
        var titles: Array<String> = [title]
        guard let i = searchText.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else { return }
        let year = ""
        let url = URL(string:"https://www.omdbapi.com/?s=" + i + "&y=" + year + "&plot=short&r=json")!
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) {
            (data: Data?, response: URLResponse?, error: Error?) in // ...
            
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            //print(json)
            if let dictionary = json as? [String: Any] {
                guard let results = dictionary["Search"] as? [[String : String]] else {
                    return
                }
//                guard let titles = results.map({ $0["Title"] }) as? [String] else {
//                    return
//                }
//                guard let yearRelease = results.map({ $0["Year"] }) as? [String] else {
//                    return
//                }
                print(title)
                print(titles)
                self.filtered = results
                
//                self.filtered = titles.filter({ (text) -> Bool in
//                    let tmp: NSString = text as NSString
//                    let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//                    return range.location != NSNotFound
//                })
//                if(self.filtered.count == 0){
//                    self.searchActive = false;
//                } else {
//                    self.searchActive = true;
//                }
                
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
                    }
        
        task.resume()
        
        
        
//        filtered = titles.filter({ (text) -> Bool in
//            let tmp: NSString = text as NSString
//            
//            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//            return range.location != NSNotFound
//        })
//        if(filtered.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
//        self.tableview.reloadData()
        
    }
}


extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return 5
        }
        return data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell;
        
        
        
        if(searchActive) {
        let sessionPoster = URLSession.shared
            let urlImage = URL(string:filtered[indexPath.row]["Poster"]!)!
        
        
        let task = sessionPoster.dataTask(with: urlImage) {
            (data: Data?, response: URLResponse?, error: Error?) in //
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                //let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                cell.poster.image = image
            }
            
            
            //let image = UIImage(data: data)
            
            

            
            
        }
            task.resume()
        }
        if(searchActive){
            cell.filteredCell?.text = filtered[indexPath.row]["Title"]
            cell.yearLabel?.text = filtered[indexPath.row]["Year"]
            
            
        } else {
            cell.filteredCell?.text = data[indexPath.row]["Title"];
            cell.yearLabel?.text = data[indexPath.row]["Year"]
            
        }
        
        return cell;
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
//        if (filtered == []){
//        self.selectedData = data[indexPath.row]
//        } else {
            self.selectedData = filtered[indexPath.row]
//        }
        
    }
}

