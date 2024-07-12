//
//  Videos.swift
//  PlatziProject
//
//  Created by Mike Jasso on 10/07/24.
//

import Foundation
import SwiftUI

// To parse the JSON
//
//   let videos = try? JSONDecoder().decode(Videos.self, from: jsonData)

import Foundation
import RealmSwift


// MARK: - Videos
struct Videos: Codable {
    let page, perPage, totalResults: Int
    let url: String
    let videos: [Video]
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalResults = "total_results"
        case url, videos
    }
}

// MARK: - Video
struct Video: Codable {
    let id, width, height: Int
    let url: String
    let image: String
    let duration: Int
    let user: User
    let videoFiles: [VideoFile]
    let videoPictures: [VideoPicture]
    
    var isFav: Bool {
        @ObservedResults(FavVideo.self) var favVideos
        for video in self.videoFiles {
            if (favVideos.first(where: {$0.videoID == video.id}) != nil) {
                return true
            }
        }
        
        return false
    }
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, url, image, duration, user
        case videoFiles = "video_files"
        case videoPictures = "video_pictures"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let name: String
    let url: String
}

// MARK: - VideoFile
struct VideoFile: Codable {
    let id: Int
    let quality, fileType: String
    let width, height: Int?
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case id, quality
        case fileType = "file_type"
        case width, height, link
    }
}

// MARK: - VideoPicture
struct VideoPicture: Codable {
    let id: Int
    let picture: String
    let nr: Int
}
