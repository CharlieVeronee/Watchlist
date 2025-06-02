import Foundation
import SwiftUI


struct Intermediate: View {
    @State var minimumRating: Double = 0
    @State var minWatchedDate: Date = Date()
    
    var watchlistLoader: WatchlistLoader
    let codes: [String]
    let activeUserNames: [String]
    
    
    var body: some View {
        VStack {

            Text("Minimum rating: \(String(format: "%.1f", minimumRating))")
                .font(.title2)
                .foregroundColor(.gray)
                .padding()

            Slider(
                value: $minimumRating,
                in: 0...5,
                step: 0.5
            ) {
                Text("Minimum Rating")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("5")
            }
            .padding()
            
            Text("Last Seen Before: \(minWatchedDate, formatter: self.dateFormatter)")
                                .font(.title2)
                                .foregroundColor(.gray)
            
            DatePicker("Select Date",
                       selection: $minWatchedDate,
                       in: ...Date(),
                       displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
        }
        
        
        
        NavigationLink(destination: WatchedJoint(watchlistLoader: watchlistLoader, codes: codes, activeUserNames: activeUserNames, minimumRating: minimumRating, minWatchedDate: minWatchedDate))
        {
            Text("GO TO WATCHDLIST")
                .foregroundColor(.white)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.lightBlueGray)
                .cornerRadius(10)
                .bold()
        }
        .padding(.leading, 25)
        .padding(.trailing, 25)

    }
    
    private var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }
    
    
}
