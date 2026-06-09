import SwiftUI

/// A text field tuned for German input, with optional dictation and a quick
/// row of umlaut/eszett characters for fast entry.
struct GermanTextInput: View {
    let placeholder: String
    @Binding var text: String
    var showSpecialCharacters: Bool = true
    var showDictation: Bool = true
    var onSubmit: (() -> Void)? = nil

    @FocusState private var focused: Bool

    private let specials = ["ä", "ö", "ü", "ß", "Ä", "Ö", "Ü"]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                TextField(placeholder, text: $text, axis: .vertical)
                    .textInputAutocapitalization(.sentences)
                    .autocorrectionDisabled(false)
                    .focused($focused)
                    .lineLimit(1...4)
                    .onSubmit { onSubmit?() }

                if showDictation {
                    SpeechInputButton(text: $text)
                }
            }
            .padding(12)
            .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 12))

            if showSpecialCharacters && focused {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(specials, id: \.self) { ch in
                            Button(ch) { text.append(ch) }
                                .font(.headline)
                                .frame(width: 40, height: 36)
                                .background(Color.lernSurface, in: RoundedRectangle(cornerRadius: 8))
                                .foregroundStyle(Color.lernPrimary)
                        }
                    }
                }
            }
        }
    }
}
