//
//  ContentView.swift
//  UISpotifyClone
//
//  Created by Luiz Araujo on 09/03/23.
//

import SwiftUI

struct ContentView: View {
    @State var songs = Song.getSongs()

    @State private var isPlaying  = false
    @State private var isLiked    = true
    @State private var downloaded = false
    @State private var shuffled   = false

    private let bgColor = Color(hue: 0.0, saturation: 0.0, brightness: 0.071)

    var body: some View {
        ScrollView(showsIndicators: false) {
            /// Album cover art
            GeometryReader { reader in
                let offSetY =  getOffSetY(reader: reader)
                let height: CGFloat = (reader.size.height - offSetY) + offSetY / 3
                let minHeight: CGFloat = 120
                let opacity =  (height - minHeight) / (reader.size.height - minHeight)

                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.brown, Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
                        .scaleEffect(7)

                    Image("cover")
                        .resizable()
                        .frame(width: height,
                               height: height)
                        .offset(y: offSetY)
                        .opacity(opacity)
                        .shadow(color: .black.opacity(0.5), radius: 30)
                }
                .frame(width: reader.size.width)
            }
            .frame(height: 250)

            Spacer().frame(height: 25)

            albumsDetailView
                .padding(.horizontal)

            Spacer().frame(height: 25)

            songListView
                .padding(.horizontal)
        }
        .coordinateSpace(name: CoordinateNames.scrollView.rawValue)
        .background(bgColor.ignoresSafeArea())
    }

    var albumsDetailView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Phobia")
                    .font(.title).bold()

                HStack {
                    Image("cover")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())

                    Text("Breaking Benjamin")
                        .font(.system(.subheadline, weight: .bold))

                }

                Text("Album • 2006")

                HStack(spacing: 30) {
                    Button {
                        isLiked.toggle()
                    } label: {

                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .font(.title2)
                            .imageScale(.large)
                            .foregroundColor(isLiked ? .green : .gray)
                            .padding(.top, 10)
                    }

                    Button {
                        downloaded.toggle()

                    } label: {

                        Image(systemName: downloaded ? "arrow.down.circle.fill" : "arrow.down.circle")
                            .font(.title2)
                            .imageScale(.large)
                            .foregroundColor(downloaded ? .green : .gray)
                            .padding(.top, 10)
                    }

                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .frame(maxHeight: .infinity)
                        .offset(y: 5)


                    Spacer()


                    Button {
                        shuffled.toggle()

                    } label: {

                        Image(systemName: "shuffle")
                            .font(.title2)
                            .imageScale(.large)
                            .foregroundColor(shuffled ? .green : .gray)
                            .padding(.top, 10)
                    }


                    Button {
                        isPlaying.toggle()

                    } label: {
                        ZStack {

                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.largeTitle)
                                .imageScale(.large)
                                .symbolRenderingMode(.multicolor)
                                .foregroundColor(.green)

                        }
                    }
                }
            }
            .foregroundColor(.white)

        }
    }

    var songListView: some View {
        ForEach(songs) { song in
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(song.title)
                        .font(.title3).bold()

                    Text(song.artist)
                        .font(.subheadline).opacity(0.8)
                }

                Spacer()

                Image(systemName: "ellipsis")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .frame(maxHeight: .infinity)
                    .offset(y: 5)
            }
            .frame(height: 60)
            .foregroundColor(.white)
        }
    }

    private func getOffSetY(reader: GeometryProxy) -> CGFloat {
        let offSetY: CGFloat = -reader.frame(in: .named(CoordinateNames.scrollView)).minY

        if offSetY < 0 {
            return offSetY / 1.3
        }
        return offSetY
    }
}
extension ContentView {
    enum CoordinateNames: String, Hashable {
        case scrollView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
