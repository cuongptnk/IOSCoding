//
//  Story.swift
//  Coding Challenge
//
//  Created by Wattpad Cuong on 2022-04-28.
//

import Foundation

public struct User: Codable {
    public var name: String
    public var avatar: URL
    public var fullname: String
}

public struct Story: Codable {
    public var id: String
    public var title: String
    public var user: User
    public var cover: URL
}

public struct DataWithPagination: Codable {
    public var stories: [Story]
    public var nextUrl: URL
}
