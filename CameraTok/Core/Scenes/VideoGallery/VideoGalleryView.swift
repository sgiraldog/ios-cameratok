import SwiftUI
import Combine

struct VideoGalleryView: View {
    let columns = [GridItem](repeating: GridItem(.flexible()), count: Constants.columnCount)
    
    @ObservedObject var viewModel: VideoGalleryViewModel
    
    init(coordinator: VideosCoordinator) {
        self.viewModel = .init(coordinator: coordinator)
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    DatePicker(
                        L10n.Gallery.Picker.label,
                        selection: $viewModel.date,
                        displayedComponents: .date
                    )
                    .padding()
                    
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns) {
                            ForEach(Array(viewModel.filteredVideos.enumerated()), id: \.offset) { index, video in
                                ThumbnailView(
                                    viewModel: .init(
                                        liked: video.liked,
                                        image: video.image,
                                        imageWidth: getThumbnailWidth(from: proxy),
                                        imageHeight: getThumbnailHeight(from: proxy)
                                    )
                                )
                                .onAppear {
                                    viewModel.fetchMoreVideosIfNeeded(index: index)
                                }
                                .onTapGesture {
                                    viewModel.navigateToVideos(selectedVideo: index)
                                }
                            }
                        }
                        if viewModel.filteredVideos.isEmpty {
                            Text(L10n.Gallery.NoVideos.label)
                                .frame(alignment: .center)
                                .padding()
                        }
                    }
                }
                .onAppear {
                    viewModel.onAppear(thumbnailWidth: getThumbnailWidth(from: proxy))
                }
                .onChange(of: viewModel.date) {_ in
                    viewModel.selectedDateChanged()
                }
            }
        }
    }
}

extension VideoGalleryView {
    func getThumbnailWidth(from proxy: GeometryProxy) -> CGFloat {
        return (proxy.size.width / CGFloat(Constants.columnCount)) - Constants.freeSpace
    }
    
    func getThumbnailHeight(from proxy: GeometryProxy) -> CGFloat {
        return ((proxy.size.width / CGFloat(Constants.columnCount)) - Constants.freeSpace) * Constants.heightRatio
    }
}

extension VideoGalleryView {
    enum Constants {
        static let freeSpace: CGFloat = 10
        static let columnCount = 3
        static let heightRatio: CGFloat = 2
    }
}

struct VideoGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        VideoGalleryView(coordinator: .init())
    }
}
