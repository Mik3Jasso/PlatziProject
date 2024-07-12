//
//  ContentView.swift
//  PlatziProject
//
//  Created by Mike Jasso on 10/07/24.
//

import SwiftUI
import SDWebImageSwiftUI
import RealmSwift

struct HomeFeedView: View {
    @State var videos: [Video] = []
    @State var searchText = ""
    @State var sectionTitle = "Top Videos"
    @State private var showingAlert = false
    
    @ObservedResults(FavVideo.self) var favVideos
    
    var body: some View {
        NavigationStack {
            NetworkAlert()
                .frame(maxHeight: 30)
                .padding(10)
            VStack {
                TextField("", text: $searchText, prompt: Text("Search...").foregroundColor(.gray))
                    .bold()
                    .font(.title2)
                    .padding(16)
                    .onSubmit {
                        Task{
                            do {
                                if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    let response = try await Network().fetchVideos(searchText)
                                    videos = response.videos
                                    sectionTitle = searchText
                                } else {
                                    let response = try await Network().fetchPopularVideos()
                                    videos = response.videos
                                }
                            } catch {
                                showingAlert = true
                            }
                        }
                    }
                if videos.count == 0{
                    VStack {
                        Image(systemName: "xmark.circle.fill")
                            .frame(height: 20)
                            .foregroundColor(.red)
                        Text("Video(s) not found")
                    }
                }else {
                    List {
                        ForEach(videos, id: \.id) { video in
                            ZStack {
                                NavigationLink(destination: VideoPlayerView(video: video.videoFiles.first(where: {$0.quality == "sd"}), totalDuration: Double(video.duration), videoSize: CGSize(width: video.width, height: video.height), isFav: video.isFav)) {
                                }.opacity(0)
                                VideoItem(video: video)
                                
                            }
                            .listRowBackground(Color.clear)
                            .overlay {
                                if video.isFav {
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
                    }.navigationTitle("Videos")
                }
            }
            .listStyle(.plain)
            Spacer()
            NavigationLink {
                FavList()
            } label: {
                Text("See fav videos")
                    .frame(height: 60)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(.blue)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .background(.white)
        .onAppear() {
            Task{
                do {
                    let response = try await Network().fetchPopularVideos()
                    videos = response.videos
                } catch {
                    showingAlert = true
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
