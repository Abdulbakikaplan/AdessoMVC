//
//  DetailVC.swift
//  AdessoMVC
//
//  Created by Abdülbaki Kaplan on 1/9/20.
//  Copyright © 2020 Abdülbaki Kaplan. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var result: SourcesModel!
       var searchData = [String]()
       var searching = false
       var detailResult: Details?
       var filteredResult: Details?
       var id: String?
       var defaultResult: Details?

       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setupSearchBar()
        setTitle()
        getDetails()
    }
    func setTableView() {
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }

        func setTitle() {
            navigationItem.title = result.name
        }

        private func setupSearchBar() {
            searchBar.delegate = self
        }
    
    //MARK: SERVICE CALL
         func getDetails() {
            self.id = result.id

            provider.request(.detail(id: self.id!)) { (response) in
                switch response {
                case .failure(let err):
                    print(err)
                case .success(let value):
                    let data = value.data
                    do {
                        let result = try JSONDecoder().decode(Details.self, from: data)
                        self.detailResult = result
                        self.defaultResult = result
                        self.tableView.reloadData()
                        print(result)
                        self.handleReading()

                    } catch let error {
                        print(error)
                    }
                }
            }
        }
        
        func search(with key: String) {
            if key.isEmpty {
                updatedList(result: defaultResult)
                return
            }

            filteredResult = detailResult

            let rooms = filteredResult?.articles!.filter {
                $0.title?.range(of: key, options: .caseInsensitive) != nil

            }

            filteredResult?.articles = rooms!
            updatedList(result: filteredResult)

        }

        func addToReadingList(publishedDate: String) {
            var readingListArray = UserDefaults.standard.array(forKey: "readingList") ?? [String]()

            if let readingListStringArray = readingListArray as? [String] {
                if let index = readingListStringArray.index(of: publishedDate) {
                    readingListArray.remove(at: index)
                } else {
                    readingListArray.append(publishedDate)
                }
            }

            UserDefaults.standard.set(readingListArray, forKey: "readingList")
            UserDefaults.standard.synchronize()

        }
        
        func handleReading() {
            guard let readingListArray: [String] = UserDefaults.standard.array(forKey: "readingList") as? [String] else {
                updatedList(result: detailResult)
                return
            }
            guard var result = detailResult?.articles else { return }

            for (index, item) in result.enumerated() {
                if readingListArray.contains(item.publishedDate) {
                    result[index].isAddedToReadingList = true
                }
            }

            self.detailResult?.articles = result
            updatedList(result: self.detailResult)

        }



}
extension DetailVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailResult?.articles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
        cell.delegate = self
        cell.selectionStyle = .none

        guard let article = detailResult?.articles?[indexPath.row] else { return UITableViewCell() }

        cell.configure(details: article)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailResult = detailResult?.articles?[indexPath.row].url else {return}
        guard let url = URL(string: (detailResult)) else { return }
        UIApplication.shared.openURL(url)
    }
}

extension DetailVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search(with: searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
        search(with: "")
    }

}

extension DetailVC {

    func updatedList(result: Details?) {
        guard let result = result else { return }
        self.detailResult = result
        tableView.reloadData()
    }
}

extension DetailVC: DetailTableViewCellProtocol {
    func addedToReadingList(details: DetailsModel) {

        guard let articles = self.detailResult?.articles! else { return }

        if let index = articles.firstIndex(where: {$0.publishedDate == details.publishedDate}) {
            self.detailResult?.articles![index] = details
        }

        addToReadingList(publishedDate: details.publishedDate)
    }

}
