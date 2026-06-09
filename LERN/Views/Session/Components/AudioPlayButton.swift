import SwiftUI

/// A speaker button that reads a German string aloud via the shared AudioService.
struct AudioPlayButton: View {
    let text: String
    var compact: Bool = false

    @Environment(AudioService.self) private var audio

    var body: some View {
        Button {
            if audio.isSpeaking {
                audio.stop()
            } else {
                audio.speak(text)
            }
        } label: {
            Image(systemName: audio.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
                .font(compact ? .footnote : .body)
                .foregroundStyle(Color.lernPrimary)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Play German audio")
    }
}
