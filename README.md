# LERN

An iOS app for learning German for a Goethe scholarship exam — a personal,
AI-tutored study companion built with SwiftUI, SwiftData, and the Anthropic API.

## Requirements

- Xcode (latest stable, 16+)
- iOS 18.0+ target (primary device: iPhone 16 Pro Max)
- Swift 6
- An Anthropic API key (added in-app via **Settings** → stored in the iOS Keychain)

## Getting started

1. Open `LERN.xcodeproj` in Xcode.
2. Select your development team under **Signing & Capabilities** (bundle ID `com.vaux.lern`).
3. Build and run on a device or simulator.
4. On first launch, open the **Settings** tab and paste your Anthropic API key.
   It is stored securely in the Keychain — never in source or UserDefaults.

> The Xcode project uses a **file-system-synchronized group**, so any file added
> under `LERN/` is picked up automatically — no manual project edits needed.

## Architecture

- **UI:** SwiftUI, MVVM, `@Observable` view models, `@Environment` injection
- **Persistence:** SwiftData (`UserProfile`, `StudySession`, `ErrorRecord`,
  `VocabularyItem`, `GrammarTopic`, `ExamResult`)
- **AI tutoring:** Anthropic Messages API (`claude-sonnet-4-20250514`) via
  `URLSession`, with streaming for live dialogue and structured JSON for
  production analysis and mock exams
- **Audio:** `AVSpeechSynthesizer` (de-DE TTS) and `SFSpeechRecognizer` (de-DE STT)
- **Spaced repetition:** SM-2 algorithm over errors and vocabulary
- **Charts:** Swift Charts for the trajectory, heatmap, and error-pattern views

### Folder layout

```
LERN/
├── LERNApp.swift            App entry point + SwiftData container
├── App/                     AppState, RootView
├── Models/
│   ├── SwiftData/           The six @Model types
│   └── Types/               Enums + Sendable transfer types
├── ViewModels/              One per feature area
├── Views/                   Home, Session, Progress, Curriculum, Exam, Settings
├── Services/                Anthropic, Audio, Speech, SRS, Curriculum, Notifications
├── Curriculum/              28-week plan, grammar content, vocabulary lists
└── Utilities/               Keychain, extensions, constants, exporter
```

## The session loop

Each study session runs three phases:

1. **Review** — SM-2 due items (vocabulary recall + error corrections)
2. **Lesson** — streaming AI tutor dialogue focused on the week's grammar topic
3. **Production** — free writing analysed into categorised errors (saved for SRS)

Weekend sessions automatically switch to a longer "Deep Dive" mode.

## Notes

- The AI conversation for a session lives only in memory; only structured
  outputs (errors, sessions, exam results) are persisted.
- The 28-week curriculum in `Curriculum/CurriculumData.swift` is the source of
  truth for grammar topics, vocabulary domains, and production prompts.
- API failures surface an inline retry without losing the user's written German.
