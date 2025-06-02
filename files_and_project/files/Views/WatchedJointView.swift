import SwiftUI

struct WatchedJoint: View {
    var watchlistLoader: WatchlistLoader
    let codes: [String]
    let activeUserNames: [String]
    let minimumRating: Double
    let minWatchedDate: Date


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
                        WatchedView(watchlist: movieItems, activeUserNames: activeUserNames, minimumRating: minimumRating, minWatchedDate: minWatchedDate)
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

struct WatchedView: View {
    var watchlist: [MovieItem]
    let activeUserNames: [String]
    
    let minimumRating: Double
    let minWatchedDate: Date
    
    var columns: [GridItem] = [
            GridItem(.flexible(), spacing: 20),
            GridItem(.flexible(), spacing: 20)
        ]
    

    var body: some View {
        VStack {
            
            Text("WATCHDLIST")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            

            ScrollView {
                let watchedMovies = watchlist.filter { $0.status == "completed" }
                let commonUniqueMovies = self.findCommonMoviesWatched(watchedMovies)
                
                
                
                LazyVGrid(columns: columns, spacing: 5) { // vertical spacing
                                    ForEach(commonUniqueMovies, id: \.id) { movieItem in
                                        NavigationLink(destination: MovieDetail(movieItem: movieItem)) {
                                            MovieDetailMini(movieItem: movieItem)
                                                .frame(width: 200, height: 300) // frame
                                        }
                                    }
                                }
                
                
//                ForEach(commonUniqueMovies, id: \.id) { movieItem in
//                    NavigationLink(destination: MovieDetail(movieItem:movieItem)) {
//                        VStack(alignment: .leading, spacing: 10) {
//                            Text(movieItem.movie.title)
//                                .fontWeight(.bold)
//                                .foregroundColor(.white)
//                            Text(movieItem.movie.ids.tmdb)
//                                .foregroundColor(.white)
//                        }
//                    }
//                }
            }
        }

    }
    
    private var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }

    private func findCommonMoviesWatched(_ movies: [MovieItem]) -> [MovieItem] {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        let filteredMovies = movies.filter {
            $0.status == "completed" && $0.user_rating != nil && $0.user_rating! >= Int(minimumRating * 2) &&
            $0.last_watched_at != nil && dateFormatter.date(from: $0.last_watched_at!)! <= minWatchedDate
        }
        let grouped = Dictionary(grouping: filteredMovies, by: { $0.movie.ids.simkl })
        let commonIds = grouped.filter { $1.count == activeUserNames.count }
        let uniqueMovies = commonIds.values.map { $0.first! }
        return uniqueMovies
    }
}
