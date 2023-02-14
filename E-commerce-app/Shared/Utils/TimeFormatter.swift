//
//  TimeFormatter.swift
//  E-commerce-app
//
//  Created by Shakhzod Azamatjonov on 14/02/23.
//

import Foundation

class TimeFormatter {
    static func convertDateToServerString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.string(from: date)
    }

    static func convertServerStringToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.date(from: string) ?? Date()
    }
    
    static func convertServerShortStringToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: string) ?? Date()
    }
    
    static func convertDayMonthYearFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func convertServerMonthStringToDate(_ string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "MM-yyyy"
        return dateFormatter.date(from: string) ?? Date()
    }

    static func convertToGeneralDateFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    
    
    static func convertToOnlyMonthYearDateFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func convertDateToMonthDayFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = " MMM d"
        return dateFormatter.string(from: date)
    }
    
    static func convertDateToDayMonthFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = " d MMM "
        return dateFormatter.string(from: date)
    }
    
    static func convertDateToYearFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }

    static func convertDateToMediumShortFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "EEEE d MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func convertDateToMediumDayFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "dd-MMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func convertDateToMediumDayWithDashFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func convertDateToMonthYearFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func convertDateToMediumFormat(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }

    static func getTimeWithUnitsFromString(_ string: String) -> (String, String)? {
        let dateArray = string.split(separator: ":")

        if dateArray.count > 0, let hours = Int(dateArray[0]), hours > 0 {
            return ("\(dateArray[0])", "Hours")
        } else if dateArray.count > 1 {
            return ("\(dateArray[1])", "Minutes")
        }
        return nil
    }

    static func getTimeStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

    static func getHoursAndMinutes(_ string: String) -> (Int, Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"

        guard let date = formatter.date(from: string) else { return (0, 0) }

        let hours = Calendar.current.component(.hour, from: date)
        let minutes = Calendar.current.component(.minute, from: date)

        return (hours, minutes)
    }

    static func timeBetweenNowAndDate(_ date: Date) -> String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: date, to: Date())
        if let hour = components.hour, hour > 0 {
            return "\(hour)h ago"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute)m ago"
        }

        return "NO DATA"
    }
    
    
    static func convertDateToMonthFormat(_ date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "MM"
        return Int(dateFormatter.string(from: date)) ?? 0
    }
    
    
    static func convertDateFormatWithSuffix(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "d'\(self.daySuffix(date))' MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func daySuffix(_ date: Date) -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: date)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
    
}
