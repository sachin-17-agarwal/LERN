import SwiftUI

/// Flame icon plus the consecutive study-day count.
struct StreakBadge: View {
    let streak: Int

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "flame.fill")
                .foregroundStyle(streak > 0 ? Color.lernAccent : .gray)
            Text("\(streak)")
                .font(.headline)
            Text(streak == 1 ? "day" : "days")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.lernSurface, in: Capsule())
    }
}
