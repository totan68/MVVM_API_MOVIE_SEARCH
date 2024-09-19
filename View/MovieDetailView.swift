
//import SwiftUI
//
//struct MovieDetailView: View {
//    
//    
//    @ObservedObject private var viewModel = MovieDetailViewModel()
//    let imdbId: String
//    
//    init(imdbId: String) {
//        self.imdbId = imdbId
//    }
//    
//    var body: some View {
//        VStack {
//            if viewModel.isLoaded {
//                MovieImage(movieImageWidthSize: AppConstants.shared.movieDetailImageWidthSize, movieImageHeightSize: AppConstants.shared.movieDetailImageWidthSize, url: viewModel.movieDetail?.poster ?? "")
//                
//                
//                Text(viewModel.movieDetail?.title ?? "")
//                    .font(.largeTitle)
//                    .bold()
//                    .padding()
//                
//                viewModel.trimText("Year: ", value: viewModel.movieDetail?.year ?? "No Year")
//                
//                viewModel.trimText("Director: ", value: viewModel.movieDetail?.director ?? "No Director")
//                
//                viewModel.trimText("Writer: ", value: viewModel.movieDetail?.writer ?? "No Writer")
//                
//            } else {
//                CircularProgressView()
//            }
//        }.task {
//            await viewModel.getMovieDetails(imbdId: imdbId)
//        }
//    }
//}
//
//
//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView(imdbId: "")
//    }
//}
import SwiftUI

struct MovieDetailView: View {
    
    @ObservedObject private var viewModel = MovieDetailViewModel()
    let imdbId: String
    
    init(imdbId: String) {
        self.imdbId = imdbId
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoaded {
               
                MovieImage(movieImageWidthSize: AppConstants.shared.movieDetailImageWidthSize, movieImageHeightSize: AppConstants.shared.movieDetailImageWidthSize, url: viewModel.movieDetail?.poster ?? "")
                    
                    .scaledToFill()
                    .frame(height: 300)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
                    .padding()
                
               
                Text(viewModel.movieDetail?.title ?? "Unknown Title")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.yellow)
                    .padding(.top)
                
                // Movie Details
                VStack(alignment: .leading, spacing: 10) {
                    detailRow(label: "Year:", value: viewModel.movieDetail?.year ?? "No Year")
                    detailRow(label: "Director:", value: viewModel.movieDetail?.director ?? "No Director")
                    detailRow(label: "Writer:", value: viewModel.movieDetail?.writer ?? "No Writer")
                }
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(10)
                .padding([.leading, .trailing, .bottom])
                
                Spacer() // Ensure content is not covered by bottom elements
            } else {
                CircularProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    .padding()
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.gray.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
        .task {
            await viewModel.getMovieDetails(imbdId: imdbId)
        }
    }
    
    // Helper function to create a row for movie details
    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.orange)
                .bold()
            Text(value)
                .font(.body)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(imdbId: "tt1234567")
    }
}
