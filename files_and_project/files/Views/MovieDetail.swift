import Foundation
import SwiftUI

struct MovieDetail: View {
    @State var movieItem: MovieItem
    let imageLoader = ImageLoader(apiClient: ImageAPIClient())
    let detailsLoader = DetailsLoader(apiClient: DetailsAPIClient())
    let creditsLoader = CreditsLoader(apiClient: CreditsAPIClient())
    
    
    var body: some View {
        
        VStack{
            
            
            switch imageLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(_): ScrollView { Text("Error Loading Image") }
            case .success(let imageResponse):
                if let firstImagePath = imageResponse.posters.first?.file_path {
                    ImageDisplay(imagePath: firstImagePath)
                } else {Image(systemName: "popcorn")
                }
            }
            
            Text(movieItem.movie.title)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            Spacer()
            .background(.darkBlueGray)
            
            
        }
        .background(.darkBlueGray)
        .task { await imageLoader.loadImage(movieId: movieItem.movie.ids.tmdb)
        }
        
        
        VStack{
            switch creditsLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(_): ScrollView { Text("Error Loading DETAILS") }
            case .success(let credits):
                CreditsDispley(credits: credits)
            }
            
        }
        .background(.darkBlueGray)
        .task { await creditsLoader.loadCredits(movieId: movieItem.movie.ids.tmdb)
        }
        
        VStack{
            
            switch detailsLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(_): ScrollView { Text("Error Loading DETAILS") }
            case .success(let details):
                DetailsDispley(details: details)
            }
            
        }
        .background(.darkBlueGray)
        .task { await detailsLoader.loadDetails(movieId: movieItem.movie.ids.tmdb)
        }
        
        
        
    }
    
    
}



struct CreditsDispley: View {
    let credits: CreditsResponse
    
    var body: some View {
        VStack {
            ForEach(credits.crew?.filter { $0.job?.lowercased() == "director" } ?? [], id: \.self) { director in
                
                Text(director.name ?? "Unknown")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .background(Color.darkBlueGray)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 15)
                
                
            }
        }
        .background(.darkBlueGray)
    }
}


struct DetailsDispley: View {
    let details: DetailsResponse
    var body: some View {
        VStack{
            
            //            if details.popularity != nil {
            //                Text(details.popularity)}
            //            else {
            //                Text("No Score")
            //
            //            }
            Text(details.release_date?.dropLast(6) ?? "try")
                .multilineTextAlignment(.leading)
                .bold()
                .font(.title2)
                .foregroundColor(.white)
                .padding(.top, 15)
            HStack{
                Text(String("Runtime: \((details.runtime ?? 0))min"))
                    .multilineTextAlignment(.trailing)
                    .bold()
                    .font(.title3)
                    .foregroundColor(.white)
                Text(String("Average Rating: \((details.vote_average ?? 0.0)/2.0)").dropLast(2))
                    .multilineTextAlignment(.trailing)
                    .bold()
                    .font(.title3)
                    .foregroundColor(.white)
                    .background(.darkBlueGray)
            }
            
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .padding(.bottom, 20)
            .background(.darkBlueGray)
            
            Text(details.overview ?? "Popularity not available")
                .multilineTextAlignment(.leading)
                .bold()
                .foregroundColor(.white)
                .italic()
                .padding(.leading, 25)
                .padding(.trailing, 25)
            
            
        }
        .background(.darkBlueGray)
        
    }
}


struct ImageDisplay: View {
    let imagePath: String
    var mainURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/original" + imagePath)
    }
    
    var body: some View  {
        VStack{
            AsyncImage(url: mainURL) { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 600, maxHeight: 600)
                
            } placeholder: {
                if mainURL != nil {
                    ProgressView()
                        .font(.largeTitle)
                } else {
                    Image(systemName: "popcorn")
                }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .background(.darkBlueGray)
        
        
        
    }
}


struct MovieDetailMini: View {
    @State var movieItem: MovieItem
    let imageLoader = ImageLoader(apiClient: ImageAPIClient())
    var body: some View {
        VStack{
            switch imageLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(_): ScrollView { Text("Error Loading Image") }
            case .success(let imageResponse):
                if let firstImagePath = imageResponse.posters.first?.file_path {
                    ImageDisplayMini(imagePath: firstImagePath)
                } else {Image(systemName: "popcorn")
                }
            }
            
        }
        .background(.darkBlueGray)
        .task { await imageLoader.loadImage(movieId: movieItem.movie.ids.tmdb)
        }
        
    }
    
}


struct ImageDisplayMini: View {
    let imagePath: String
    var mainURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/original" + imagePath)
    }
    
    var body: some View  {
        AsyncImage(url: mainURL) { image in image
                .resizable()
                .scaledToFill()
                .cornerRadius(5)
            
        } placeholder: {
            if mainURL != nil {
                ProgressView()
                    .font(.largeTitle)
            } else {
                Image(systemName: "popcorn")
            }
        }
        .frame(maxWidth: .infinity)
    }
}
