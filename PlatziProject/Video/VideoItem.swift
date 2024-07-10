//
//  VideoItem.swift
//  PlatziProject
//
//  Created by Mike Jasso on 10/07/24.
//

import SwiftUI

struct VideoItem: View {
    let video: VideoFile
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Name")
                    .font(.headline)
                Text("Artist:")
                    .font(.subheadline)
                Text("Duration:")
                    .font(.subheadline)
                Text("Style:")
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    VideoItem(video: VideoFile(id: 1, quality: "s", fileType: "Type", width: 100, height: 100, link: "URL"))
}
