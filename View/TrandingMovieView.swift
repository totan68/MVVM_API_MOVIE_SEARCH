import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, isSearching: $isSearching)
                    .padding()

                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.searchedMovies, id: \.imbdId) { movie in
                        HStack {
                            AsyncImage(url: URL(string: movie.poster)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 150)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 150)
                                case .empty:
                                    ProgressView()
                                        .frame(width: 100, height: 150)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                    .font(.headline)
                                Text(movie.year)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search Movies")
            .onChange(of: searchText) { newValue in
                Task {
                    if !newValue.isEmpty {
                        await viewModel.searchMovies(search: newValue)
                    } else {
                        viewModel.searchedMovies = []
                    }
                }
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    @Binding var isSearching: Bool
    
    class Coordinator: NSObject, UISearchBarDelegate {
        var searchBar: SearchBar
        
        init(searchBar: SearchBar) {
            self.searchBar = searchBar
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchBar.text = searchText
            searchBar.searchTextField.clearButtonMode = .whileEditing
            searchBar.searchTextField.autocapitalizationType = .none
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            searchBar.searchTextField.clearButtonMode = .never
            searchBar.searchTextField.autocapitalizationType = .sentences
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(searchBar: self)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search Movies"
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

