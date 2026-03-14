// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public typealias FocusField = Hashable & CaseIterable

public struct FieldInputNavigationToolbar<Field: FocusField>: ViewModifier where Field.AllCases: RandomAccessCollection  {
	
	
	typealias FocusStateBinding = FocusState<Field?>.Binding
	
	var focusField: FocusStateBinding
	
	public init(focusField: FocusState<Field?>.Binding) {
		self.focusField = focusField
	}
	
	var nextField: Field? {
		guard let currentField = focusField.wrappedValue else { return nil }
		let all = Array(Field.allCases)
		guard let index = all.firstIndex(of: currentField), all.indices.contains(index + 1) else { return nil }
		return all[index + 1]
	}
	
	var previousField: Field? {
		guard let currentField = focusField.wrappedValue	else { return nil }
		let all = Array(Field.allCases)
		guard let index = all.firstIndex(of: currentField), all.indices.contains(index - 1) else { return nil }
		return all[index - 1]
	}
	
	var hasPrevious: Bool {
		self.previousField != nil
	}
	
	var hasNext: Bool {
		self.nextField != nil
	}
	
	public func body(content: Content) -> some View {
		return content
			.safeAreaBottomToolbar(isPresented: focusField.wrappedValue != nil){
				HStack {
					HStack {
						ToolbarButton(
							isDisabled: !hasPrevious,
							onTap: { focusField.wrappedValue = previousField },
							systemImage: "chevron.up"
						)
						
						ToolbarButton(
							isDisabled: !hasNext,
							onTap: { focusField.wrappedValue = nextField },
							systemImage: "chevron.down"
						)
					
					}
					
					Spacer()
					
					ToolbarButton(
						isDisabled: false,
						onTap: { focusField.wrappedValue = nil },
						systemImage: "checkmark"
					)
					
				}
			}
	}
}

public extension View {
	func fieldInputNavigationToolbar<Field: FocusField>(focusField: FocusState<Field?>.Binding) -> some View where Field.AllCases: RandomAccessCollection {
		self.modifier(FieldInputNavigationToolbar(focusField: focusField))
	}
}

struct ContentView: View {
	enum FocusFields: Hashable, CaseIterable {
		case first, last
	}
	
	@FocusState private var currentField: FocusFields?
	@State private var firstName: String = ""
	@State private var lastName: String = ""
	
	var body: some View {
		Form {
			TextField("First name", text: $firstName)
				.focused($currentField, equals: .first)
			
			TextField("First name", text: $lastName)
				.focused($currentField, equals: .last)
		}
		.fieldInputNavigationToolbar(focusField: $currentField)
	}
}

#Preview {
	ContentView()
}

