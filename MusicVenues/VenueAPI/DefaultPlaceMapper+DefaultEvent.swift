//
//  DefaultPlaceMapper.swift
//  PhillyJams
//
//  Created by Daveed Balcher on 8/5/22.
//

import Foundation

extension DefaultPlaceMapper.Root {
    
    enum ReocurringOptions: String {
        case oneOff, weekly
    }
    
    struct DefaultEvent: Decodable {
        let name: String
        let day_of_the_week: String
        let reoccuring: [String]
        let start_time: String
        let end_time: String
        let hosts: [String]
        let url: String
        let properties: [String: [String]]
        
        var dates: [Date] {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(abbreviation: "EST")!
            var components = DateComponents()
            components.weekday = weekday
            components.hour = hour
            components.minute = minutes
            
            let direction = Calendar.SearchDirection.forward
            let initialDate = calendar.nextDate(after: Date(),
                                                matching: components,
                                                matchingPolicy: .nextTime,
                                                direction: direction)!
            
            var mappedDates = [Date]()
            
            for i in (0...4) {
                mappedDates.append(calendar.date(byAdding: .weekOfMonth, value: i, to: initialDate)!)
            }
            return mappedDates
        }
        
        var weekday: Int {
            dateStringToInt(day_of_the_week, from: "EEEE", to: "e")
        }
        
        var hour: Int {
            dateStringToInt(start_time, from: "h:mm a", to: "H")
        }
        
        var minutes: Int {
            dateStringToInt(start_time, from: "h:mm a", to: "mm")
        }
        
        func dateStringToInt(_ value: String, from fromFormat: String, to toFormat: String) -> Int {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = fromFormat
            let date = dateFormatter.date(from: value)
            dateFormatter.dateFormat = toFormat
            let string = dateFormatter.string(from: date!)
            return Int(string)!
        }
        
        var durationInMinutes: Int {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            let startTime = dateFormatter.date(from: start_time)!
            var endTime = dateFormatter.date(from: end_time)!
            
            if endTime < startTime {
                let calendar = Calendar(identifier: .gregorian)
                endTime = calendar.date(byAdding: .day, value: 1, to: endTime)!
            }
            
            let duration = endTime.timeIntervalSince(startTime)
            return Int(duration/60)
        }
        
        var isReoccuring: Bool {
            !reoccuring.contains { $0 == ReocurringOptions.oneOff.rawValue }
        }
        
        var item: Event {
            Event(title: name,
                  description: "",
                  hosts: hosts,
                  dates: dates,
                  duration: durationInMinutes,
                  isReoccuring: isReoccuring,
                  properties: properties.map { Property(title: $0.key, values: $0.value)}.sorted(),
                  url: URL(string: url)
            )
        }
    }
}
