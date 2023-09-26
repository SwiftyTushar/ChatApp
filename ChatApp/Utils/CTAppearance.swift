//
//  CTAppearance.swift
//  ChatApp
//
//  Created by Tushar Patil on 17/09/23.
//

import Foundation

enum DateformatStyles: String{
    case standard = "dd/MM/yyyy"
    case dateZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case standardTime = "h:mm a"
}

class CTAppearance{
    static func getFormatter(style:DateformatStyles) -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = style.rawValue
        return formatter
    }
    static func convertFrom(from:DateformatStyles,to:DateformatStyles,date:String) -> String{
        let formatter = DateFormatter()
        if from == .dateZ{
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(abbreviation: "UTC")
        }
        let fromObj = formatter.date(from: date)
        formatter.dateFormat = to.rawValue
        return formatter.string(from: fromObj ?? Date())
    }
}
