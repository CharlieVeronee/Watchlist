import Foundation
import SwiftData

struct DetailsResponse: Decodable {
    var genres: [genres]?
    var overview: String?
    var vote_average: Double?
    var runtime: Int?
    var release_date: String?
}

struct genres: Decodable {
    
    var id: Int
    var name: String?
    
}
