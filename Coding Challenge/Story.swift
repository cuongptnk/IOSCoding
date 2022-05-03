//
//  Story.swift
//  Coding Challenge
//
//  Created by Wattpad Cuong on 2022-04-28.
//

import Foundation

struct User: Codable {
    var name: String
    var avatar: URL
    var fullname: String
}

struct Story: Codable {
    var id: String
    var title: String
    var user: User
    var cover: URL
}

struct DataWithPagination: Codable {
    var stories: [Story]
    var nextUrl: URL
}
