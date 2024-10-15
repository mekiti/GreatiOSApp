import SwiftUI

struct EntryFieldView: View {
    let placeHolder: String
    let icon: ImageResource

    @State var text = ""
    @State var isEditing = false

    private var opacity: CGFloat {
        isEditing ? 1 : 0.6
    }

    var body: some View {
        HStack(spacing: 0) {
            Image(icon)
                .resizable()
                .frame(
                    width: Constants.texfieldIconSize,
                    height: Constants.texfieldIconSize
                )
                .padding(.leading, Constants.EntryFieldView.padding)
                .opacity(opacity)
            TextField(placeHolder, text: $text, onEditingChanged: { changed in
                isEditing = changed
            })
                .padding(Constants.EntryFieldView.padding)
        }
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(.textFieldBackground)
        )
    }
}

#Preview {
    EntryFieldView(placeHolder: "placeHolder", icon: .lockIcon)
        .padding()
}
