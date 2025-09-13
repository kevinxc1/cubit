//
//  SolveTimeList.swift
//  Cubit
//

import Foundation
import RealmSwift

class SolveTimeList: Object
{
    let list = List<SolveTime>()
    
    convenience init(_ times: [SolveTime]) {
        self.init()
        for time in times
        {
            list.append(time)
        }
    }
    
    
}
