//
//  ContentView.swift
//  PlatziProject
//
//  Created by Mike Jasso on 10/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeFeedView: View {
    @State var videos: [Video] = []
    @State var searchText = ""
    @State var sectionTitle = "Top Videos"
    @State var isFirstTime = true
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("", text: $searchText, prompt: Text("Search...").foregroundColor(.gray))
                    .bold()
                    .font(.title2)
                    .border(.gray, width: 1)
                    .padding(16)
                    .onSubmit {
                        Task{
                            do {
                                let response = try await Network().fetchData(searchText)
                                print("Response: \(response)")
                                videos = response.videos
                                sectionTitle = searchText
                            } catch {
                                showingAlert = true
                            }
                        }
                    }
                List {
                    Section(sectionTitle) {
                        ForEach(videos, id: \.id) { video in
                            ZStack {
                                NavigationLink(destination: VideoPlayerView(video: video.videoFiles.first(where: {$0.quality == "sd"}), totalDuration: Double(video.duration), videoSize: CGSize(width: video.width, height: video.height))) {
                                }.opacity(0)
                                VideoItem(video: video)
                                
                            }
                            .listRowBackground(Color.clear)
                            .overlay {
                                if video.isSaved {
                                    Image(systemName: "star.fill")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(Circle())
                                        .padding(.leading, 0)
                                        .padding(.top, 80)
                                }
                            }
                            
                        }
                    }
                    
                }
            }
            .listStyle(.plain)
            Spacer()
            Button("Ver videos guardados") {
                
            }
            .frame(height: 60)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .cornerRadius(16)
            .background(.blue)
            .font(.title3)
            .bold()
            .foregroundColor(.white)
        }
        .background(.white)
        .onAppear() {
            if isFirstTime {
                Task{
                    do {
                        let response = try await Network().fetchPopularVideos()
                        print("Response: \(response)")
                        videos = response.videos
                        isFirstTime = false
                    } catch {
                        print("Error")
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text("Videos couldn't load correctly"), dismissButton: .default(Text("OK")))
        }
    }
}





#Preview {
    HomeFeedView()
}
