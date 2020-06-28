//
//  ViewController.swift
//  MyTelstra_Evaluation
//
//  Created by N, Azik Abdullah (Cognizant) on 27/06/20.
//  Copyright © 2020 N, Azik Abdullah (Cognizant). All rights reserved.
//

import UIKit
let kServiceURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let infoTableView = UITableView()
    var facts:Facts?
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(infoTableView)
        
        setupTableView()
        callService()
    }

    func setupTableView() {
        //Tableview constraints
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        infoTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        infoTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        infoTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        infoTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        //setting tableview delegate and dataSource
        infoTableView.dataSource = self
        infoTableView.delegate = self
        infoTableView.register(InfoCell.self, forCellReuseIdentifier: "contentCell")
        
        //Pull to refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(callService), for: .valueChanged)
        infoTableView.addSubview(refreshControl)
    }
    
    @objc func callService() {
        NetworkManager().fetchJsonData(kServiceURL, completionHandler: { (responseData,error) in
            if let responseData = responseData, error == nil {
                self.facts = responseData
                DispatchQueue.main.async {//do UI changes in main queue
                    self.navigationItem.title = self.facts?.title ?? ""
                    self.infoTableView.reloadData()
                    if self.refreshControl.isRefreshing {//stop refreshing
                        self.refreshControl.endRefreshing()
                    }
                }
            } else {
                print("Service call error")
            }
        })
    }
}

extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts?.rows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! InfoCell
        cell.factContent = facts?.rows?[indexPath.row]//load service data in Tablecells
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let font: UIFont = UIFont.boldSystemFont(ofSize: 14)
        var labelHeight:CGFloat = 0.0
        if let cellFact:FactContent = facts?.rows?[indexPath.row] {
            labelHeight = heightForView(text: cellFact.description ?? "", font: font, width: self.view.frame.size.width - 100)//calculate height of label w.r.t text length
        }
        let rowHeight = labelHeight + 50//Label y position addded
        return rowHeight > 100 ? rowHeight : 100 //minimum height is 100
    }

    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height + 10//Padding height = 10
    }
}
