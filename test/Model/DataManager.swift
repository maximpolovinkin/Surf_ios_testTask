//
//  DataManager.swift
//  test
//
//  Created by Максим Половинкин on 07.02.2023.
//

import Foundation

final class DataManager {
    /// Names, that using in CollectionView
    let  names =  ["IOS", "Android", "Flutter", "Design", "QA", "PM", "JS",
                   "C#", "DevOps", "GO"]
    
    /// Give names
    /// - Returns: array of names
    func obtainData() -> [String]{
        return names
    }
}
