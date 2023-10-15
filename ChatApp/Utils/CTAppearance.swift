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
    case message = "dd MMM yyyy"
}

class CTAppearance{
    static func getFormatter(style:DateformatStyles) -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = style.rawValue
        return formatter
    }
    static func convertFrom(from:DateformatStyles,to:DateformatStyles,date:String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = from.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        if let fromObj = formatter.date(from: date){
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = to.rawValue
            return outputFormatter.string(from: fromObj)
        }
        return ""
    }
    static func getDate(from date:String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = DateformatStyles.dateZ.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        if let mDate = formatter.date(from: date){
            return mDate
        }
        return Date()
    }
    static func compareDates(firstDate:Date,secondDate:Date) -> Bool{
        let formatter = DateFormatter()
        formatter.dateFormat = DateformatStyles.standard.rawValue
        return formatter.string(from: firstDate) == formatter.string(from: secondDate)
    }
    static func getFormattedDates(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = DateformatStyles.message.rawValue
        if formatter.string(from: date) == formatter.string(from: Date()){
            return "Today"
        } else if date == Date.yesterday{
            return "Yesterday"
        }
        return formatter.string(from: date)
    }
    static func getDate(milliseconds:Double) -> Date{
        return Date(timeIntervalSince1970: milliseconds/1000.0)
    }
}
