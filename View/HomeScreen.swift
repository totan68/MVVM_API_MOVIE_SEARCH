//import SwiftUI
//
//struct HomeView: View {
//    @State private var isSearchActive = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                
//                TabView {
//                    Image("1stM")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(height: 200)
//                        .clipped()
//
//                    Image("2ndM")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(height: 200)
//                        .clipped()
//
//                    Image("3rdM")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(height: 200)
//                        .clipped()
//                }
//                .tabViewStyle(PageTabViewStyle())
//                .frame(height: 200)
//                .padding(.bottom, 10)
//                
//             
//                HStack {
//                    Text("Now Playing")
//                        .font(.title)
//                        .fontWeight(.bold)
//                    
//                    Spacer()
//                }
//                .padding(.horizontal)
//                
//                
//                VStack {
//                    Spacer()
//                
//             
//                    Text("Explore movies and find your favorite!")
//                        .padding()
//                    
//                    Spacer()
//                }
//                
//              
//                HStack {
//                    Button(action: {
//                        
//                        print("Home button tapped")
//                    }) {
//                        Image(systemName: "house.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 24, height: 24)
//                            .padding()
//                    }
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        isSearchActive = true
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 24, height: 24)
//                            .padding()
//                    }
//                }
//                .background(Color.gray.opacity(0.1))
//                .edgesIgnoringSafeArea(.bottom)
//                .sheet(isPresented: $isSearchActive) {
//                   MovieSearchView()
//                }
//            }
//            .navigationTitle("Home")
//            .background(
//                LinearGradient(
//                    gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//                .edgesIgnoringSafeArea(.all)
//            )
//        }
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
//
//
//



import SwiftUI

struct HomeView: View {
    @State private var isSearchActive = false
    @State private var isProfileActive = false
    @State private var currentPage = 0

    // Define arrays for images
    let carouselImages = ["1stM", "2ndM", "3rdM"] // Replace with your actual image names
    let moviePosters = ["4thM", "5thM", "6thM", "7thM", "8thM"] // Replace with your actual image names

    var body: some View {
        NavigationView {
            VStack {
                // Enhanced TabView with Carousel Styling
                TabView(selection: $currentPage) {
                    ForEach(carouselImages.indices, id: \.self) { index in
                        Image(carouselImages[index])
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                            .padding(.horizontal, 10)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: 200)
                .padding(.bottom, 10)
                
                // Page Indicator
                HStack {
                    ForEach(carouselImages.indices, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.white : Color.gray.opacity(0.5))
                            .frame(width: 8, height: 8)
                            .padding(2)
                    }
                }
                .padding(.bottom, 10)
                
                // Now Playing Text
                HStack {
                    Text("Now Playing")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.purple, Color.blue]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .cornerRadius(10)
                        )
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                // Hardcoded Movie Posters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(moviePosters, id: \.self) { posterName in
                            Image(posterName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 180)
                                .clipped()
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 200)
                
                // Placeholder Text
                VStack {
                    Spacer()
                    Text("Explore movies and find your favorite!")
                        .padding()
                    Spacer()
                }
                
                // Bottom Buttons
                HStack {
                    Button(action: {
                        print("Home button tapped")
                    }) {
                        Image(systemName: "house.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        print("Profile button tapped")
                        isProfileActive = true
                    }) {
                        Image(systemName: "person.fill") // Profile icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                    .sheet(isPresented: $isProfileActive) {
                      ProfileView()// Replace with your actual profile view
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isSearchActive = true
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                }
                .background(Color.gray.opacity(0.1))
                .edgesIgnoringSafeArea(.bottom)
                .sheet(isPresented: $isSearchActive) {
                    MovieSearchView()
                }
            }
            .navigationTitle("Home")
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
