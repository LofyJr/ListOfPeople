//
//  AvatarView.swift
//  ListOfPeople
//
//  Created by Juliano Lofy Junior on 29/01/24.
//

import SwiftUI

struct AvatarEditProfileHandler: EnvironmentKey {
    static var defaultValue: (() -> Void)?
}

extension EnvironmentValues {
    var editProfileHandler: (() -> Void)? {
        get { self[AvatarEditProfileHandler.self] }
        set { self[AvatarEditProfileHandler.self] = newValue }
    }
}

extension View {
    public func onEditPofileHandler(editProfileHandler: @escaping () -> Void) -> some View {
        environment(\.editProfileHandler, editProfileHandler)
    }
}

enum AvatarImageShape {
    case round
    case rectangle
}

struct AvatarImageShapeKey: EnvironmentKey {
    static var defaultValue: AvatarImageShape = .round
}

extension EnvironmentValues {
    var avatarImageShape: AvatarImageShape {
        get { self[AvatarImageShapeKey.self] }
        set { self[AvatarImageShapeKey.self] = newValue }
    }
}

extension View {
    func avatarImageShape(_ imageShape: AvatarImageShape) -> some View {
        environment(\.avatarImageShape, imageShape)
    }
}

struct AvatarView: View {
    @Environment(\.avatarImageShape) var imageShape
    @Environment(\.editProfileHandler) var editProfileHandler
    var person: Person

    @ViewBuilder
    private var profileImage: some View {
        if imageShape == .round {
            Image(person.profileImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75, alignment: .center)
                .clipShape(.circle)
                .accessibilityLabel(person.fullName)
        } else {
            Image(person.profileImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75, alignment: .center)
                .accessibilityLabel(person.fullName)
        }
    }

    private var titleLabel: some View {
        Text(person.fullName)
            .font(.headline)
    }

    private func detailsLabel(_ text: String) -> some View {
        Text(text)
            .font(.subheadline)
    }

    var body: some View {
        HStack(alignment: .top) {
            profileImage
                .onTapGesture {
                    if let editProfileHandler {
                        editProfileHandler()
                    }
                }
            VStack(alignment: .leading, spacing: 2){
                titleLabel
                detailsLabel(person.jobtitle)
                detailsLabel(person.affiliation)
            }
            Spacer()
        }
    }
}

#Preview {
    VStack{
        AvatarView(person: Person.sample)
            .onEditPofileHandler {
                print("You've tapped on the profile image!")
            }
            .avatarImageShape(.rectangle)
            .padding()
        AvatarView(person: Person.sample)
            .padding()
    }
}
