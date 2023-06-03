//
//  Environment.swift
//  PicPractice
//
//  Created by saint on 2023/04/28.
//

import Foundation

// MARK: - Environment

struct Environment {
    static let baseURL = (Bundle.main.infoDictionary?["BASE_URL"] as! String).replacingOccurrences(of: " ", with: "")
}
