//
//  DateHelper.swift
//  EngineerAiTest
//
//  Created by MAC108 on 09/10/19.
//  Copyright © 2019 Tatvasoft. All rights reserved.
//

import Foundation
class DateHelper {
    
    class func dateInFormate(date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSz"
        let showDate = inputFormatter.date(from: date)
        inputFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
}
