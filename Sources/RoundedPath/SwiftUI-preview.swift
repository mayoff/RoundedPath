#if DEBUG && os(iOS)

import SwiftUI

@available(iOS 16, *)
struct ContentView: View {
    @State var points: [CGPoint] = []
    @State var radius: CGFloat = 10
    @State var isClosed = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Tap around to make a path.")

                ZStack {
                    SharpShape(points: points, isClosed: isClosed)
                        .stroke(.black, style: .init(dash: [2]))

                    RoundedShape(points: points, radius: radius, isClosed: isClosed)
                        .stroke(.red)

                    Rectangle()
                        .foregroundColor(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture { p in
                            points.append(p)
                        }
                }

                VStack {
                    Toggle("Closed", isOn: $isClosed)

                    HStack {
                        Text("Radius: ")
                        Slider(value: $radius, in: 0 ... 100)
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(role: .destructive) {
                        points = []
                    } label: {
                        Label("Clear", systemImage: "trash")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

@available(iOS 13, *)
struct SharpShape: Shape {
    var points: [CGPoint]
    var isClosed: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addLines(points)
        if isClosed {
            path.closeSubpath()
        }
        return path
    }
}

@available(iOS 13, *)
struct RoundedShape: Shape {
    var points: [CGPoint]
    var radius: CGFloat
    var isClosed: Bool

    func path(in rect: CGRect) -> Path {
        let sharpPath = CGMutablePath()
        sharpPath.addLines(between: points)
        if isClosed {
            sharpPath.closeSubpath()
        }

        let roundedPath = sharpPath.copy(roundingCornersToRadius: radius)
        return Path(roundedPath)
    }
}


@available(iOS 16, *)
struct Previews_SwiftUI_preview_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#endif
