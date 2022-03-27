import SwiftUI

struct ScoresScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    let gameCountSql = "SELECT COUNT(*) FROM games;"
    let scoreSql = "SELECT SUM(LENGTH(word)) AS score FROM rounds GROUP BY game_id ORDER BY score DESC;"
    
    var scores: [String] {
        let rows = RottenDB.shared.selectRows(scoreSql)
        let points = rows.compactMap() { $0.first as? Int64 }
        return points.map() { "\($0) points" }
    }
    
    var summaryLine: String {
        let gameCount = try! RottenDB.sharedClient.scalar(gameCountSql) as! Int64
        return "\(gameCount) games played"
    }
    
    var body: some View {
        VStack {
            HStack() {
                Text("Top Scores")
                    .font(Font.futura(30))
                Spacer()
                RottenButton("done", action: handleDonePress)
            }
            
            Text(summaryLine)
                .font(Font.futura(30))
            
            ForEach(scores, id: \.self) { score in
                Text(score)
                    .font(Font.futura(30))
            }
            
            Spacer()
        }
        .padding(20)
        .navigationBarHidden(true)
    }
    
    func handleDonePress() {
        dismiss()
    }
}

struct ScoresScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScoresScreen()
            .preferredColorScheme(.dark)
    }
}
