//
//  NewsEndPoint.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//

import Foundation

enum NewsEndPoint {
    case everything(query: String)
}


extension NewsEndPoint: EndPointType {
    
    var baseURL: String {
        return "https://newsapi.org/v2/"
    }
    
    var path: String {
        switch self {
        case .everything:
            return "everything"
        }
    }
    
    var method: HTTPMethods {
        return .get
    }
    
    var headers: [String: String]? {
        APIManager.commonHeaders
    }
    
    var body: Encodable? {
        return nil
    }
    
    var url: URL? {
        var components = URLComponents(string: baseURL + path)
        
        let range = Self.dateRange()
        
        components?.queryItems = [
            URLQueryItem(name: "q", value: queryValue),
            URLQueryItem(name: "from", value: range.from),
            URLQueryItem(name: "to", value: range.to),
            URLQueryItem(name: "sortBy", value: "popularity"),
            URLQueryItem(name: "apiKey", value: AppConfig.newsAPIKey)
        ]
        
        return components?.url
    }
    
    private var queryValue: String {
        switch self {
        case .everything(let query):
            return query
        }
    }
    
    private static func dateRange() -> (from: String, to: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: today)!
        
        return (
            formatter.string(from: sevenDaysAgo),
            formatter.string(from: today)
        )
    }
    
}
