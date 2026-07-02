import SwiftUI

/// A text field tuned for German input, with a quick row of umlaut/eszett
/// characters. For dictation, users tap the microphone on the iOS keyboard —
/// which does reliable German speech-to-text without any in-app audio handling.
struct GermanTextInput: View {
    let placeholder: String
    @Binding var text: String
    var showSpecialCharacters: Bool = true
    var onSubmit: (() -> Void)? = nil

    @FocusState private var focused: Bool

    private let specials = ["ä", "ö", "ü", "ß", "Ä", "Ö", "Ü"]

    var body: some View {
        HStack(spacing: 8) {
            TextField(placeholder, text: $text, axis: .vertical)
                .textInputAutocapitalization(.sentences)
                .autocorrectionDisabled(false)
                .focused($focused)
                .lineLimit(1...4)
                .onSubmit { onSubmit?() }
        }
        .padding(12)
        .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 12))
        // Umlauts and a keyboard-dismiss control live in the accessory bar above
        // the keyboard, so they don't eat the on-screen content and the keyboard
        // can always be closed with the chevron.
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if showSpecialCharacters {
                    ForEach(specials, id: \.self) { ch in
                        Button(ch) { text.append(ch) }
                            .font(.headline)
                            .foregroundStyle(Color.lernPrimary)
                    }
                }
                Spacer()
                Button {
                    focused = false
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                        .font(.title3)
                }
                .accessibilityLabel("Dismiss keyboard")
            }
        }
    }
}
