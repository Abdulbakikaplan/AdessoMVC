//
//  ResourcesVC.swift
//  AdessoMVC
//
//  Created by Abdülbaki Kaplan on 1/9/20.
//  Copyright © 2020 Abdülbaki Kaplan. All rights reserved.
//

import UIKit

class ResourcesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var result : News?
    let cell = "ResourcesTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        getNews()
    }

    func setTableView() {
        tableView.register(UINib(nibName: cell, bundle: nil), forCellReuseIdentifier: cell)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func getNews() {

        provider.request(.search) { (response) in
            switch response {
            case .failure(let err):
                print(err)
            case .success(let value):
                let data = value.data
                do {
                    let result = try JSONDecoder().decode(News.self, from: data)
                    self.result = result
                    print(result)
                    self.tableView.reloadData()
                    print(result.sources)
                } catch let error {
                    print(error)
                }
            }
        }
    }

}

extension ResourcesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = result?.sources.count else { return 0}
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourcesTableViewCell", for: indexPath) as! ResourcesTableViewCell
        guard let source = result?.sources[indexPath.row] else { return UITableViewCell() }
        cell.configure(source: source)

        return cell
    }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
    }
    
    
}
