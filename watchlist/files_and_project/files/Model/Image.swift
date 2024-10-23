import Foundation
import SwiftData

struct ImageResponse: Decodable {
    var posters: [ImageMain]
}

struct ImageMain: Decodable {
    var aspect_ratio: Double
    var height: Int
    var iso_639_1: String?
    var file_path: String
    var vote_average: Double
    var vote_count: Int
    var width: Int
}
