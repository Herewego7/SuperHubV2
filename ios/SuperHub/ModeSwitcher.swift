import SwiftUI

enum AppMode: String, CaseIterable, Identifiable {
    case familyHub
    case botLife

    var id: String { rawValue }

    var title: String {
        switch self {
        case .familyHub: "Family Hub"
        case .botLife: "Bot Life"
        }
    }

    var accessibilityIdentifier: String {
        switch self {
        case .familyHub: "mode.familyHub"
        case .botLife: "mode.botLife"
        }
    }
}

struct ModeSwitcher: View {
    @Binding var mode: AppMode

    var body: some View {
        HStack(spacing: 8) {
            ForEach(AppMode.allCases) { item in
                Button {
                    mode = item
                } label: {
                    Text(item.title)
                        .font(.subheadline.weight(mode == item ? .semibold : .regular))
                        .frame(maxWidth: .infinity, minHeight: 36)
                }
                .buttonStyle(.plain)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(mode == item ? Color.accentColor.opacity(0.18) : Color.clear)
                )
                .accessibilityIdentifier(item.accessibilityIdentifier)
                .accessibilityAddTraits(mode == item ? .isSelected : [])
            }
        }
        .padding(4)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.secondary.opacity(0.12)))
        .accessibilityIdentifier("mode.switcher")
    }
}
