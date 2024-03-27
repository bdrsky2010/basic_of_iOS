//
//  ContactsFeature.swift
//  TheComposableArchitectureEX
//
//  Created by Minjae Kim on 3/23/24.
//

import SwiftUI
import ComposableArchitecture

struct Contact: Equatable, Identifiable {
	let id: UUID
	var name: String
}

@Reducer
struct ContactsFeature {
	@ObservableState
	struct State: Equatable {
//		@Presents var addContact: AddContactFeature.State? // 기능 통합
//		@Presents var alert: AlertState<Action.Alert>?
		var contacts: IdentifiedArrayOf<Contact> = []
		@Presents var destination: Destination.State?
		var path = StackState<ContactDetailFeature.State>()
	}
	
	enum Action {
		case addButtonTapped
		case deleteButtonTapped(id: Contact.ID)
		// PresentationAction을 통해 부모는 자식 기능에서 send된 작업을 관찰할 수 있음
//		case addContact(PresentationAction<AddContactFeature.Action>)
//		case alert(PresentationAction<Alert>)
		case destination(PresentationAction<Destination.Action>)
		case path(StackAction<ContactDetailFeature.State, ContactDetailFeature.Action>)
		enum Alert: Equatable {
			case confirmDeletion(id: Contact.ID)
		}
	}
	
	@Dependency(\.uuid) var uuid
	
	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .addButtonTapped:
				state.destination = .addContact(
					AddContactFeature.State(
						contact: Contact(id: UUID(), name: "")
					)
				)
				return .none
			
			// PresentationAction.presented(_:) 을 사용하여
			// 'AddContactFeature' 내의 작업을 수신
			case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
				state.contacts.append(contact)
				return .none
				
			case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
				state.contacts.remove(id: id)
				return .none
				
			case .destination:
				return .none
				
			case let .deleteButtonTapped(id: id):
				state.destination = .alert(.deleteConfirmation(id: id))
				return .none
				
			case let .path(.element(id: id, action: .delegate(.confirmDeletion))):
				guard let detailState = state.path[id: id] else { return .none }
				state.contacts.remove(id: detailState.contact.id)
				return .none
				
			case .path:
				return .none
			}
		}
		// ifLet을 사용하여 Reducer 통합
		.ifLet(\.$destination, action: \.destination)
		// forEach를 사용하여 ContactsFeature의 스택에 ContactDetailFeature를 통합
		.forEach(\.path, action: \.path) {
			ContactDetailFeature()
		}
	}
}

extension AlertState where Action == ContactsFeature.Action.Alert {
	static func deleteConfirmation(id: UUID) -> Self {
		Self {
			TextState("Are you sure?")
		} actions: {
			ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
				TextState("Delete")
			}
		}
	}
}

// 도메인 모델링 개선
extension ContactsFeature {
	@Reducer(state: .equatable)
	enum Destination {
		case addContact(AddContactFeature)
		case alert(AlertState<ContactsFeature.Action.Alert>)
	}
}

@Reducer
struct AddContactFeature {
	@ObservableState
	struct State: Equatable {
		var contact: Contact
	}
	
	enum Action {
		case cancelButtonTapped
		case delegate(Delegate)
		case saveButtonTapped
		case setName(String)
		// Delegate를 통해 하위 기능이 원하는 작업을 상위 기능에 알릴 수 있다
		@CasePathable
		enum Delegate: Equatable {
			case saveContact(Contact)
		}
	}
	
	// 상위 기능과 접촉없이 하위 기능이 스스로 닫힐 수 있도록 dismissEffect
	@Dependency(\.dismiss) var dismiss
	
	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .cancelButtonTapped:
				return .run{ _ in await self.dismiss() }
				
			case .delegate:
				return .none
				
			case .saveButtonTapped:
				return .run { [contact = state.contact] send in
					await send(.delegate(.saveContact(contact)))
					await self.dismiss()
				}
				
			case let .setName(name):
				state.contact.name = name
				return .none
			}
		}
	}
}

struct AddContactView: View {
	// TCA에서 바인딩하기 위한 Bindable 매크로 사용
	@Bindable var store: StoreOf<AddContactFeature>
	
	var body: some View {
		Form {
			// TCA에서 바인딩하는 작업
			TextField("Name", text: $store.contact.name.sending(\.setName))
			Button("Save") {
				store.send(.saveButtonTapped)
			}
		}
		.toolbar {
			Button("Cancel") {
				store.send(.cancelButtonTapped)
			}
		}
	}
}

#Preview {
	NavigationStack {
		AddContactView(
			store: Store(
				initialState: AddContactFeature.State(
					contact: Contact(
						id: UUID(),
						name: "Blob"
					)
				)
			) {
				AddContactFeature()
			}
		)
	}
}
