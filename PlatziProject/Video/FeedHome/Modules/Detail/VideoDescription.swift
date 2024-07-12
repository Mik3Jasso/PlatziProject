//
//  VideoDescription.swift
//  PlatziProject
//
//  Created by Mike Jasso on 12/07/24.
//

import SwiftUI

struct VideoDescription: View {
    var videoFile: VideoFile?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Video description")
                .bold()
                .font(.title)
                .foregroundStyle(.white)
            Text("Quality: \(videoFile?.quality ?? "")")
                .italic()
                .font(.title3)
                .foregroundStyle(.white)
            Text("Type: \(videoFile?.fileType ?? "")")
                .italic()
                .font(.title3)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 120)
        .background(.gray)
        .cornerRadius(16)
    }
}

#Preview {
    VideoDescription(videoFile: VideoFile(id: 23, quality: "sd", fileType: "mp4", width: 100, height: 100, link: "https://videos.pexels.com/video-files/5386411/5386411-sd_506_960_25fps.mp4"))
}
