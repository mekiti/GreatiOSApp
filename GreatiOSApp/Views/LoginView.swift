import SwiftUI
import Observation

struct LoginView: View {
    @State private var viewModel = LoginViewModel(authService: AuthService(repository: AuthRepositoryImpl()))

    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()

            if viewModel.isLoading {
                VStack(spacing: 8) {
                    ProgressView()
                        .font(.footnote)

                    Text(Constants.loadingString)
                        .foregroundStyle(.loadingText)
                }
            } else {
                VStack(spacing: 0) {
                    Image(.logo)
                        .padding(.bottom, Constants.imagePadding)

                    EntryFieldView(
                        text: $viewModel.username,
                        placeHolder: Constants.usernameString,
                        icon: .userIcon
                    )
                    .padding(.bottom, Constants.entryFieldPadding)

                    EntryFieldView(
                        text: $viewModel.password,
                        placeHolder: Constants.passwordString,
                        icon: .lockIcon,
                        isSecure: true
                    )
                    .padding(.bottom, Constants.buttonPadding)

                    Button {
                        Task {
                            await viewModel.login()
                        }
                    } label: {
                        Text(Constants.loginString)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.button)
                    .alert(isPresented: $viewModel.showingAlert) {
                        Alert(
                            title: Text(viewModel.alertTitleString),
                            message: Text(viewModel.alertMessageString),
                            dismissButton: .default(Text(Constants.alertOk))
                        )
                    }
                }
                .padding(Constants.loginPadding)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
    }
}

#Preview {
    LoginView()
}
