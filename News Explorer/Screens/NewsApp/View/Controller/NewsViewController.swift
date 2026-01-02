//
//  NewsViewController.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//


import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var searchNewsByAuthor: UISearchBar!
    @IBOutlet weak var newsTableView: UITableView!
    
    private var viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    func setUpUI() {
        newsTableView.backgroundColor = UIColor.lightGray
    }
}

extension NewsViewController {
    
    func configuration() {
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil),
                               forCellReuseIdentifier: "NewsCell")
        
        newsTableView.dataSource = self
        searchNewsByAuthor.delegate = self
        
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchNews()
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                print("Article loading....")
            case .stopLoading:
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            case .error(let error):
                print(error ?? "error found")
            }
        }
    }
    
}

extension NewsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterByAuthor(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.resetSearch()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let article = viewModel.articles[indexPath.row]
        cell.article = article
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

