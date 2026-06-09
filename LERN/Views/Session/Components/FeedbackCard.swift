import SwiftUI

/// Displays a single AI-classified error: wrong vs corrected text, category,
/// and the one-sentence rule explanation.
struct FeedbackCard: View {
    let wrongText: String
    let correctedText: String
    let category: ErrorCategory
    let explanation: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: category.symbolName)
                Text(category.displayName)
                    .font(.caption.weight(.semibold))
                Spacer()
            }
            .foregroundStyle(Color.lernError)

            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "xmark.circle.fill").foregroundStyle(Color.lernError)
                Text(wrongText).strikethrough().foregroundStyle(.secondary)
            }
            HStack(alignment: .top, spacing: 6) {
                Image(systemName: "checkmark.circle.fill").foregroundStyle(Color.lernSuccess)
                HStack(spacing: 6) {
                    Text(correctedText).fontWeight(.medium)
                    AudioPlayButton(text: correctedText, compact: true)
                }
            }

            Text(explanation)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 14))
    }
}
