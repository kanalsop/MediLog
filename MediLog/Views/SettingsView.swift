import AVFoundation
import SwiftData
import SwiftUI
import UIKit

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @Query(sort: \Medication.createdAt) private var medications: [Medication]

    @AppStorage(NotificationPreferences.soundEnabledKey) private var soundEnabled = true
    @AppStorage(NotificationPreferences.selectedSoundKey) private var selectedSoundID = MedicationNotificationSound.bell.rawValue
    @AppStorage(AppTheme.selectedThemeKey) private var selectedThemeID = AppThemeMode.light.rawValue
    @AppStorage(TimeFormatPreferences.selectedTimeFormatKey) private var selectedTimeFormatID = AppTimeFormat.twentyFourHour.rawValue

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    settingsSection("通知") {
                        SettingsOnOffRow(
                            title: "通知音",
                            systemImage: "speaker.wave.2.fill",
                            isOn: $soundEnabled
                        )

                        SettingsSoundSelectionRow(
                            selectedSoundID: $selectedSoundID
                        )

                        Button {
                            if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                                openURL(url)
                            }
                        } label: {
                            SettingsRowContent(
                                title: "端末の通知設定",
                                value: nil,
                                systemImage: "bell.badge.fill",
                                accessorySystemImage: "arrow.up.forward.app.fill",
                                isLink: true
                            )
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("端末の通知設定を開く")
                    }

                    settingsSection("一般") {
                        SettingsThemeSelectionRow(
                            selectedThemeID: $selectedThemeID
                        )

                        SettingsTimeFormatSelectionRow(
                            selectedTimeFormatID: $selectedTimeFormatID
                        )
                    }

                    settingsSection("アプリ情報") {
                        NavigationLink {
                            SettingsDocumentView(document: .termsOfUse)
                        } label: {
                            SettingsRowContent(
                                title: "利用規約",
                                value: nil,
                                systemImage: "doc.text.fill",
                                accessorySystemImage: "chevron.right"
                            )
                        }

                        NavigationLink {
                            SettingsDocumentView(document: .privacyPolicy)
                        } label: {
                            SettingsRowContent(
                                title: "プライバシーポリシー",
                                value: nil,
                                systemImage: "lock.shield.fill",
                                accessorySystemImage: "chevron.right"
                            )
                        }

                        NavigationLink {
                            SettingsDocumentView(document: .licenses)
                        } label: {
                            SettingsRowContent(
                                title: "ライセンス",
                                value: nil,
                                systemImage: "list.bullet.rectangle.fill",
                                accessorySystemImage: "chevron.right"
                            )
                        }
                    }
                }
                .padding(20)
            }
            .background(AppTheme.background)
            .navigationTitle("設定")
            .preferredColorScheme(selectedTheme.preferredColorScheme)
            .animation(.easeInOut(duration: 0.25), value: selectedThemeID)
            .animation(.easeInOut(duration: 0.2), value: selectedTimeFormatID)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("閉じる") {
                        dismiss()
                    }
                    .foregroundStyle(AppTheme.primaryStrong)
                }
            }
            .onChange(of: soundEnabled) { _, _ in
                refreshMedicationNotifications()
            }
            .onChange(of: selectedSoundID) { _, _ in
                refreshMedicationNotifications()
            }
        }
    }

    private var selectedTheme: AppThemeMode {
        AppThemeMode(rawValue: selectedThemeID) ?? .light
    }

    private func settingsSection<Content: View>(
        _ title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline.weight(.bold))
                .foregroundStyle(AppTheme.text)

            VStack(spacing: 0) {
                content()
            }
            .background(AppTheme.card, in: RoundedRectangle(cornerRadius: 18))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(AppTheme.outline, lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
    }

    private func refreshMedicationNotifications() {
        Task {
            for medication in medications {
                await NotificationManager.shared.refreshNotifications(for: medication)
            }
        }
    }
}

private struct SettingsRow: View {
    let title: String
    let value: String
    let systemImage: String

    var body: some View {
        SettingsRowContent(
            title: title,
            value: value,
            systemImage: systemImage,
            accessorySystemImage: nil
        )
    }
}

private struct SettingsOnOffRow: View {
    let title: String
    let systemImage: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 12) {
            SettingsRowIcon(systemImage: systemImage)

            Text(title)
                .font(.body.weight(.semibold))
                .foregroundStyle(AppTheme.text)

            Spacer(minLength: 12)

            HStack(spacing: 4) {
                optionButton(title: "OFF", value: false)
                optionButton(title: "ON", value: true)
            }
            .padding(3)
            .background(AppTheme.pendingBackground, in: Capsule())
        }
        .frame(minHeight: 58)
        .padding(.horizontal, 14)
        .padding(.vertical, 4)
    }

    private func optionButton(title: String, value: Bool) -> some View {
        Button {
            isOn = value
        } label: {
            Text(title)
                .font(.caption.weight(.bold))
                .foregroundStyle(isOn == value ? AppTheme.background : AppTheme.secondaryText)
                .frame(width: 48, height: 30)
                .background(
                    Capsule()
                        .fill(isOn == value ? AppTheme.primaryStrong : Color.clear)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(title)にする")
    }
}

private struct SettingsSoundSelectionRow: View {
    @Binding var selectedSoundID: String
    @State private var isExpanded = false
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button {
                withAnimation(.snappy) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 12) {
                    SettingsRowIcon(systemImage: "music.note")

                    Text("サウンド選択")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(AppTheme.text)

                    Spacer(minLength: 12)

                    Text(selectedSound.title)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(AppTheme.secondaryText)

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(AppTheme.secondaryText)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
                .frame(minHeight: 40)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("サウンド選択")

            if isExpanded {
                VStack(spacing: 8) {
                    ForEach(MedicationNotificationSound.allCases) { sound in
                        HStack(spacing: 8) {
                            Button {
                                play(sound)
                            } label: {
                                Image(systemName: "play.fill")
                                    .font(.subheadline.weight(.bold))
                                    .foregroundStyle(AppTheme.primaryStrong)
                                    .frame(width: 42, height: 42)
                                    .background(AppTheme.primarySoft, in: Circle())
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("\(sound.title)を再生")

                            Button {
                                selectedSoundID = sound.rawValue
                            } label: {
                                HStack {
                                    Text(sound.title)
                                        .font(.subheadline.weight(.semibold))

                                    Spacer()

                                    if selectedSoundID == sound.rawValue {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(AppTheme.primaryStrong)
                                    } else {
                                        Image(systemName: "circle")
                                            .foregroundStyle(AppTheme.secondaryText)
                                    }
                                }
                                .foregroundStyle(AppTheme.text)
                                .padding(.horizontal, 12)
                                .frame(height: 42)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(selectedSoundID == sound.rawValue ? AppTheme.primarySoft : AppTheme.pendingBackground)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
    }

    private var selectedSound: MedicationNotificationSound {
        MedicationNotificationSound(rawValue: selectedSoundID) ?? .bell
    }

    private func play(_ sound: MedicationNotificationSound) {
        guard let url = Bundle.main.url(forResource: sound.resourceName, withExtension: "caf") else { return }

        audioPlayer?.stop()
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
}

private struct SettingsThemeSelectionRow: View {
    @Binding var selectedThemeID: String

    var body: some View {
        HStack(spacing: 12) {
            SettingsRowIcon(systemImage: "paintpalette.fill")

            Text("テーマ")
                .font(.body.weight(.semibold))
                .foregroundStyle(AppTheme.text)

            Spacer(minLength: 12)

            HStack(spacing: 4) {
                ForEach(AppThemeMode.allCases) { theme in
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            selectedThemeID = theme.rawValue
                        }
                    } label: {
                        Text(theme.title)
                            .font(.caption.weight(.bold))
                            .foregroundStyle(selectedThemeID == theme.rawValue ? AppTheme.background : AppTheme.secondaryText)
                            .frame(width: 52, height: 30)
                            .background(
                                Capsule()
                                    .fill(selectedThemeID == theme.rawValue ? AppTheme.primaryStrong : Color.clear)
                            )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("\(theme.title)テーマにする")
                }
            }
            .padding(3)
            .background(AppTheme.pendingBackground, in: Capsule())
        }
        .frame(minHeight: 58)
        .padding(.horizontal, 14)
        .padding(.vertical, 4)
    }
}

private struct SettingsTimeFormatSelectionRow: View {
    @Binding var selectedTimeFormatID: String
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button {
                withAnimation(.snappy) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 12) {
                    SettingsRowIcon(systemImage: "clock.fill")

                    Text("時間の表示形式")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(AppTheme.text)

                    Spacer(minLength: 12)

                    Text(selectedTimeFormat.title)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(AppTheme.secondaryText)

                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(AppTheme.secondaryText)
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                }
                .frame(minHeight: 40)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("時間の表示形式")

            if isExpanded {
                VStack(spacing: 8) {
                    ForEach(AppTimeFormat.allCases) { format in
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedTimeFormatID = format.rawValue
                            }
                        } label: {
                            HStack(spacing: 12) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(format.title)
                                        .font(.subheadline.weight(.bold))

                                    Text(format.description)
                                        .font(.caption.weight(.medium))
                                        .foregroundStyle(AppTheme.secondaryText)
                                }

                                Spacer()

                                if selectedTimeFormatID == format.rawValue {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(AppTheme.primaryStrong)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundStyle(AppTheme.secondaryText)
                                }
                            }
                            .foregroundStyle(AppTheme.text)
                            .padding(.horizontal, 12)
                            .frame(minHeight: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(selectedTimeFormatID == format.rawValue ? AppTheme.primarySoft : AppTheme.pendingBackground)
                            )
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel("\(format.description)にする")
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
    }

    private var selectedTimeFormat: AppTimeFormat {
        AppTimeFormat(rawValue: selectedTimeFormatID) ?? .twentyFourHour
    }
}

private struct SettingsRowContent: View {
    let title: String
    let value: String?
    let systemImage: String
    let accessorySystemImage: String?
    var isLink = false

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.body.weight(.semibold))
                .foregroundStyle(isLink ? AppTheme.primaryStrong : AppTheme.secondaryText)
                .frame(width: 32, height: 32)
                .background(
                    (isLink ? AppTheme.primarySoft : AppTheme.pendingBackground),
                    in: Circle()
                )

            Text(title)
                .font(.body.weight(.semibold))
                .foregroundStyle(isLink ? AppTheme.primaryStrong : AppTheme.text)

            Spacer(minLength: 12)

            if let value {
                Text(value)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(AppTheme.secondaryText)
            }

            if let accessorySystemImage {
                Image(systemName: accessorySystemImage)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(isLink ? AppTheme.primaryStrong : AppTheme.secondaryText)
            }
        }
        .frame(minHeight: 54)
        .padding(.horizontal, 14)
        .padding(.vertical, 4)
        .contentShape(Rectangle())
    }
}

private struct SettingsRowIcon: View {
    let systemImage: String

    var body: some View {
        Image(systemName: systemImage)
            .font(.body.weight(.semibold))
            .foregroundStyle(AppTheme.secondaryText)
            .frame(width: 32, height: 32)
            .background(AppTheme.pendingBackground, in: Circle())
    }
}

private struct SettingsDocumentView: View {
    let document: LegalDocument

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(document.title)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(AppTheme.text)

                    Text(document.effectiveDate)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(AppTheme.secondaryText)
                }

                VStack(alignment: .leading, spacing: 20) {
                    ForEach(document.sections) { section in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(section.title)
                                .font(.headline.weight(.bold))
                                .foregroundStyle(AppTheme.text)

                            Text(section.body)
                                .font(.body)
                                .lineSpacing(4)
                                .foregroundStyle(AppTheme.secondaryText)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
        }
        .background(AppTheme.background)
        .navigationTitle(document.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SettingsView()
}
