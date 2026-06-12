import SwiftUI

/// Surfaces the recommended exam level, estimated scores, and Goethe-Institut
/// Sydney booking information.
struct ExamReadinessCard: View {
    let recommendation: ProgressViewModel.ExamRecommendation

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Label("Exam Readiness", systemImage: "checkmark.seal.fill")
                    .font(.headline)
                Spacer()
                if recommendation.bookNow {
                    Text("Book Now")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10).padding(.vertical, 4)
                        .background(Color.lernError, in: Capsule())
                }
            }

            Text(recommendation.message)
                .font(.subheadline)

            // Estimated scores per level
            HStack(spacing: 12) {
                ForEach(["A1", "A2", "B1"], id: \.self) { level in
                    VStack(spacing: 4) {
                        Text(level).font(.caption.weight(.semibold))
                        Text("\(Int(recommendation.estimatedScores[level] ?? 0))")
                            .font(.title3.weight(.bold))
                            .lernStatNumber()
                            .foregroundStyle(level == recommendation.level ? Color.lernSuccess : .primary)
                        Text("/100").font(.caption2).foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(
                        Color.lernBackground,
                        in: RoundedRectangle(cornerRadius: 10, style: .continuous)
                    )
                }
            }

            Divider()

            VStack(alignment: .leading, spacing: 6) {
                Text("Goethe-Institut Sydney").font(.caption.weight(.semibold))
                contactRow(icon: "mappin.and.ellipse", text: Constants.Goethe.address)
                contactRow(icon: "envelope", text: Constants.Goethe.email)
                contactRow(icon: "phone", text: Constants.Goethe.phone)
                Link(destination: URL(string: Constants.Goethe.url)!) {
                    contactRow(icon: "safari", text: "Book an exam")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .lernCard()
    }

    private func contactRow(icon: String, text: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon).frame(width: 18).foregroundStyle(Color.lernPrimary)
            Text(text).font(.footnote)
        }
    }
}
