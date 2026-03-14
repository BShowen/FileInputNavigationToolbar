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
					HStack(spacing: 30) {
						Button {
							focusField.wrappedValue = previousField
						} label: {
							Image(systemName: "chevron.up")
								.resizable()
								.scaledToFit()
								.frame(width: 20, height: 20)
						}
						.buttonStyle(.plain)
						.contentShape(Rectangle().size(CGSize(width: 44, height: 44)))
						.disabled(!hasPrevious)
						
						Button {
							focusField.wrappedValue = nextField
						} label: {
							Image(systemName: "chevron.down")
								.resizable()
								.scaledToFit()
								.frame(width: 20, height: 20)
						}
						.buttonStyle(.plain)
						.contentShape(Rectangle().size(CGSize(width: 44, height: 44)))
						.disabled(!hasNext)
					}
					
					Spacer()
					
					Button {
						focusField.wrappedValue = nil
					} label: {
						Image(systemName: "checkmark")
							.resizable()
							.scaledToFit()
							.frame(width: 20, height: 20)
					}
					.buttonStyle(.plain)
					
				}
			}
	}
}

public extension View {
	func fieldInputNavigationToolbar<Field: FocusField>(focusField: FocusState<Field?>.Binding) -> some View where Field.AllCases: RandomAccessCollection {
		self.modifier(FieldInputNavigationToolbar(focusField: focusField))
	}
}

