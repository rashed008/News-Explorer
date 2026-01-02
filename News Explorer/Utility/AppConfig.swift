//
//  AppConfig.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//


import Foundation

enum AppConfig {

    static var newsAPIKey: String {
        guard let key = Bundle.main.object(
            forInfoDictionaryKey: "NEWS_API_KEY"
        ) as? String else {
            fatalError("NEWS_API_KEY not found in Info.plist")
        }
        return key
    }
}
