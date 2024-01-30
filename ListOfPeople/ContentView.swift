//
//  ContentView.swift
//  ListOfPeople
//
//  Created by Juliano Lofy Junior on 29/01/24.
//

import SwiftUI

struct ContentView: View {
    @State var people = Person.samples
    @State var participantes = Person.samples.filter { $0.isParticipant }

    var body: some View {
        List {
            Section("Participants") {
                ForEach(participantes) { person in
                    AvatarView(person: person)
                        .avatarImageShape(.round)
                }
            }

            Section("Speakers") {
                ForEach(people) { person in
                    AvatarView(person: person)
                }
            }
        }
        .avatarImageShape(.rectangle)
    }
}

#Preview {
    ContentView()
}
