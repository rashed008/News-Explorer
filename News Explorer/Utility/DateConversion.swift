//
//  DateConversion.swift
//  News Explorer
//
//  Created by Rashed Pervez on 2/1/26.
//

import Foundation

extension String {

    func toReadableDate() -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        guard let date = isoFormatter.date(from: self) else {
            return self
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy, hh:mm a"
        formatter.timeZone = TimeZone.current

        return formatter.string(from: date)
    }
}

