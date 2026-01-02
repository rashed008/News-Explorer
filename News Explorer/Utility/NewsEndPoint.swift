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
    
    // MARK: - Base URL
    var baseURL: String {
        return "https://newsapi.org/v2/"
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .everything:
            return "everything"
        }
    }
    
    // MARK: - HTTP Method
    var method: HTTPMethods {
        return .get
    }
    
    // MARK: - Headers
    var headers: [String: String]? {
        APIManager.commonHeaders
    }
    
    // MARK: - Body
    var body: Encodable? {
        return nil
    }
    
    // MARK: - URL
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
    
    // MARK: - Helpers
    private var queryValue: String {
        switch self {
        case .everything(let query):
            return query
        }
    }
    
    //    private static func todayDate() -> String {
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "yyyy-MM-dd"
    //        return formatter.string(from: Date())
    //    }
    
    private static func dateRange() -> (from: String, to: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: today)!
        
        return (
            formatter.string(from: sevenDaysAgo),
            formatter.string(from: today)
        )
    }
    
}
