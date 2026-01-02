//
//  NewsViewModel.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//

import Foundation

extension NewsViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}

final class NewsViewModel {
    
    var eventHandler: ((_ event: Event) -> Void)?
    private(set) var articles: [Article] = []
    private var allArticles: [Article] = []
    
    func fetchNews() {
        eventHandler?(.loading)
        
        APIManager.shared.request(
            modelType: NewsResponse.self,
            type: NewsEndPoint.everything(query: "apple")
        ) { [weak self] response in
            guard let self else { return }
            
            self.eventHandler?(.stopLoading)
            
            switch response {
            case .success(let newsResponse):
                self.allArticles = newsResponse.articles
                self.articles = newsResponse.articles
                self.eventHandler?(.dataLoaded)
                
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func filterByAuthor(_ author: String) {
        guard !author.isEmpty else {
            articles = allArticles
            eventHandler?(.dataLoaded)
            return
        }
        
        articles = allArticles.filter {
            $0.author?.lowercased().contains(author.lowercased()) == true
        }
        
        eventHandler?(.dataLoaded)
    }
    
    func resetSearch() {
        articles = allArticles
        eventHandler?(.dataLoaded)
    }
}
