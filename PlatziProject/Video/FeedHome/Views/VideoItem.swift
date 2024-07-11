//
//  VideoItem.swift
//  PlatziProject
//
//  Created by Mike Jasso on 10/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct VideoItem: View {
    let video: Video
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                WebImage(url: URL(string: video.image))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 100)
                    .cornerRadius(16)
                    .padding(8)
                    .clipped()
                VStack {
                    Text("Duration: \(video.duration) seg")
                        .font(.headline)
                        .bold()
                    Text("Height: \(video.height) px")
                        .font(.subheadline)
                        .italic()
                    Text("Width: \(video.width) px")
                        .font(.subheadline)
                        .italic()

                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(.gray.opacity(0.2))
        .cornerRadius(16)
        .padding(8)
    }
}

#Preview {
    VideoItem(video: Video(id: 1, width: 100, height: 100, url: "URL", image: "https://content.nationalgeographic.com.es/medio/2022/12/12/perro-1_514aad3b_221212161023_1280x720.jpg", duration: 200, user: User(id: 2, name: "User 1", url: "URL"), videoFiles: [], videoPictures: []))
}
