//
//  ContentView.swift
//  UISpotifyClone
//
//  Created by Luiz Araujo on 09/03/23.
//

import SwiftUI

struct ContentView: View {
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
                    LinearGradient(gradient: Gradient(colors: [Color.green, Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
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

            // Test scroll
            ForEach(0..<100) { _ in
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 100)
                    .opacity(0.3)
            }
        }
        .coordinateSpace(name: CoordinateNames.scrollView.rawValue)
        .background(bgColor.ignoresSafeArea())
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
