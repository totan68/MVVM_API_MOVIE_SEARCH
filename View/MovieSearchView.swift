
import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject private var viewModel = MovieViewModel()
    
    @State private var searchMovie = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Text Field
                TextField("Search for movies...", text: $searchMovie, onCommit: {
                    Task {
                        do {
                            let trimmedSearch = searchMovie.trimmingCharacters(in: .whitespacesAndNewlines)
                            let encodedSearch = trimmedSearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? trimmedSearch
                            await viewModel.searchMovies(search: encodedSearch)
                        }
                    }
                })
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .textFieldStyle(PlainTextFieldStyle())
                .shadow(radius: 5)
                
                if viewModel.isLoading {
                    CircularProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                        .padding()
                } else {
                                        List(viewModel.searchedMovies, id: \.imbdId) { movie in
                                            NavigationLink(destination: MovieDetailView(imdbId: movie.imbdId), label: {
                                              HStack {
                                                    MovieImage(movieImageWidthSize: AppConstants.shared.movieImageWidthSize, movieImageHeightSize: AppConstants.shared.movieImageHeightSize, url: movie.poster)
                    
                                               VStack(alignment: .leading) {
                    
                                                    Text(movie.title)
                                                          .font(.title2)
                                                          .bold()
                                                           .foregroundColor(.orange)
                    
                                                       Text(movie.year)
                    
                                                       Spacer()
                                }
                                .padding(.leading, 8)
                            }
                            .padding(.vertical, 4)
                        })
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
            .navigationTitle("Search Movies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
