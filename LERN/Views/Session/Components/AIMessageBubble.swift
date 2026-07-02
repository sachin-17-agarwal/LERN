import SwiftUI

/// A chat-style message bubble for the lesson dialogue. AI messages get a
/// speaker button so the user can hear the German read aloud.
struct AIMessageBubble: View {
    let message: Message
    var isStreaming: Bool = false

    private var isUser: Bool { message.role == .user }

    var body: some View {
        HStack(alignment: .top) {
            if isUser { Spacer(minLength: 40) }

            VStack(alignment: .leading, spacing: 6) {
                Text(message.content.isEmpty && isStreaming ? AttributedString("…") : message.content.inlineMarkdown)
                    .foregroundStyle(isUser ? .white : .primary)
                    .textSelection(.enabled)

                if !isUser && !message.content.isEmpty {
                    AudioPlayButton(text: message.content, compact: true, germanOnly: true)
                }
            }
            .padding(12)
            .background(
                isUser ? Color.lernPrimary : Color.lernSurface,
                in: UnevenRoundedRectangle(
                    topLeadingRadius: 18,
                    bottomLeadingRadius: isUser ? 18 : 6,
                    bottomTrailingRadius: isUser ? 6 : 18,
                    topTrailingRadius: 18,
                    style: .continuous
                )
            )
            .shadow(color: Color.black.opacity(isUser ? 0 : 0.05), radius: 5, y: 2)

            if !isUser { Spacer(minLength: 40) }
        }
    }
}
