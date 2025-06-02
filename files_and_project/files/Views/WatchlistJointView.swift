import SwiftUI

struct WatchlistJoint: View {
    var watchlistLoader: WatchlistLoader
    let codes: [String]
    let activeUserNames: [String]
    
    
    var body: some View {
        ZStack{
            Color("DarkBlueGray")
                .ignoresSafeArea()
            ScrollView{
                VStack {
                    
                    switch watchlistLoader.state {
                    case .idle: Color.clear
                    case .loading: ProgressView()
                    case .failed(let error): ScrollView { Text("Error \(error.localizedDescription)") }
                    case .success(let movieItems):
                        WatchlistView(watchlist: movieItems, activeUserNames: activeUserNames)
                            .background(Color("DarkBlueGray"))
                    }
                }
                .task { await watchlistLoader.loadWatchlistData(codes: codes) }
                .background(Color("DarkBlueGray"))
            }
            .background(Color("DarkBlueGray"))
        }
        
        
    }
    
    
}


struct WatchlistView: View {
    var watchlist: [MovieItem]
    let activeUserNames: [String]
    
    var columns: [GridItem] = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]

    var body: some View {
        VStack {
            Text("JOINT WATCHLIST")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)

            ScrollView {
                let plantowatchMovies = watchlist.filter { $0.status == "plantowatch" }
                let commonUniqueMovies = self.findCommonMovies(plantowatchMovies)
                
                
//                ForEach(commonUniqueMovies, id: \.id) { movieItem in
//                    NavigationLink(destination: MovieDetail(movieItem:movieItem)) {
//                        VStack(alignment: .leading, spacing: 10) {
//                            Spacer()
//                            MovieDetailMini(movieItem:movieItem)
//                            Text(movieItem.movie.title)
//                                .fontWeight(.bold)
//                                .foregroundColor(.white)
//                                .multilineTextAlignment(.center)
//                            Text(movieItem.movie.ids.tmdb)
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.center)
//                        }
//                    }
//                
//                }
                
                LazyVGrid(columns: columns, spacing: 5) { // vertical spacing
                                    ForEach(commonUniqueMovies, id: \.id) { movieItem in
                                        NavigationLink(destination: MovieDetail(movieItem: movieItem)) {
                                            MovieDetailMini(movieItem: movieItem)
                                                .frame(width: 200, height: 300) // frame
                                        }
                                    }
                                }
                
                
                
                
            }
        }
    }
    
    private func findCommonMovies(_ movies: [MovieItem]) -> [MovieItem] {
        let filteredMovies = movies.filter { $0.status == "plantowatch" }
        let grouped = Dictionary(grouping: filteredMovies, by: { $0.movie.ids.simkl })
        let commonIds = grouped.filter { $1.count == activeUserNames.count }
        let uniqueMovies = commonIds.values.map { $0.first! }
        return uniqueMovies
    }
}




