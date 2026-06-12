import SwiftUI

/// The prominent "start today's session" call to action.
struct SessionStartCard: View {
    let sessionType: String
    let grammarTopic: String
    let vocabularyDomain: String
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Label(sessionType, systemImage: "books.vertical.fill")
                    .font(.caption.weight(.semibold))
                Spacer()
            }
            .foregroundStyle(.white.opacity(0.9))

            VStack(alignment: .leading, spacing: 4) {
                Text(grammarTopic)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.white)
                Text(vocabularyDomain)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85))
            }

            Button(action: action) {
                Label("Start Today's Session", systemImage: "play.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
            }
            .buttonStyle(.borderedProminent)
            .tint(.white)
            .foregroundStyle(Color.lernPrimary)
            .fontDesign(.rounded)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [
                    Color.lernPrimary,
                    Color.lernPrimary.opacity(0.85),
                    Color(red: 0.36, green: 0.30, blue: 0.66)
                ],
                startPoint: .topLeading, endPoint: .bottomTrailing
            ),
            in: RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .shadow(color: Color.lernPrimary.opacity(0.25), radius: 12, y: 6)
    }
}
