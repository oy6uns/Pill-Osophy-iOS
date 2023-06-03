//
//  ImageResponseDto.swift
//  PicPractice
//
//  Created by saint on 2023/04/28.
//

import Foundation

// MARK: - Welcome
struct ImageResponseDto: Codable {
    let success: Bool
    let message: String
    let drug: [[Int]]
}
