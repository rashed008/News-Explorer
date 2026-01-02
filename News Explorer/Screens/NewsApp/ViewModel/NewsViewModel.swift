//
//  NewsViewModel.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//

import Foundation

final class NewsViewModel {
    
    var articles: [Article] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchNews() {
        self.eventHandler?(.loading)
        
        APIManager.shared.request(
            modelType: NewsResponse.self,
            type: NewsEndPoint.everything(query: "apple")
        ) { response in
            
            self.eventHandler?(.stopLoading)
            
            switch response {
            case .success(let newsResponse):
                print("totalResults:", newsResponse.totalResults)
                print("articles.count:", newsResponse.articles.count)
                
                newsResponse.articles.forEach { article in
                    print("Here is your articles", article.title)
                }
                self.articles = newsResponse.articles
                self.eventHandler?(.dataLoaded)
                
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}


extension NewsViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        //case newProductAdded(product: AddProduct)
    }
    
}
