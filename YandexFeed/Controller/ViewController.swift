//
//  ViewController.swift
//  YandexFeed
//
//  Created by Evgeniy on 13.02.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var parser = XMLParser()
    var allPosts = [Post]()
    
    var eName = String()
    var eTitle = String()
    var eDescription = String()
    var eLink = String()
    
    var segueLink = String()
    
    let identifier = "MyCell"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        parser = XMLParser(contentsOf: Constants.link!)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        
        if elementName == "item" {
            eTitle = String()
            eDescription = String()
            eLink = String()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            var post = Post()
            
            post.description = eDescription
            post.link = eLink
            post.title = eTitle
            
            allPosts.append(post)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if !data.isEmpty {
            switch eName {
            case "title":
                eTitle += data
            case "description":
                eDescription += data
            case "link":
                eLink += data
            default:
                print("")
            }
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebPage" {
            let webVC = segue.destination as! WebViewController
            
            print(segueLink)
            
            webVC.link = segueLink
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.textLabel?.text = allPosts[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueLink = allPosts[indexPath.row].link
        
        performSegue(withIdentifier: "showWebPage", sender: self)
    }
}

