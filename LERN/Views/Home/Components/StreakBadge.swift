import SwiftUI

/// Flame icon plus the consecutive study-day count.
struct StreakBadge: View {
    let streak: Int

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "flame.fill")
                .foregroundStyle(
                    streak > 0
                        ? AnyShapeStyle(
                            LinearGradient(
                                colors: [Color.lernAccent, Color.lernError],
                                startPoint: .top, endPoint: .bottom
                            )
                        )
                        : AnyShapeStyle(Color.gray)
                )
            Text("\(streak)")
                .font(.headline)
                .lernStatNumber()
            Text(streak == 1 ? "day" : "days")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.lernSurface, in: Capsule())
        .shadow(color: Color.black.opacity(0.05), radius: 6, y: 2)
    }
}
