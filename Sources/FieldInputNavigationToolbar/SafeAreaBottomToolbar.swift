//
//  SafeAreaBottomToolbar.swift
//  FieldInputNavigationToolbar
//
//  Created by Bradley Showen on 3/14/26.
//

import SwiftUI

struct BottomToolbarModifier<ToolbarContent: View>: ViewModifier {
	let isPresented: Bool
	@ViewBuilder let content: () -> ToolbarContent
	
	func body(content mainContent: Content) -> some View {
		mainContent
			.safeAreaInset(edge: .bottom) {
				if isPresented {
					self.content()
						.frame(maxWidth: .infinity)
//						.padding()
						.glassEffect(.regular.interactive())
						.padding()
				}
			}
	}
}

extension View {
	func safeAreaBottomToolbar<ToolbarContent: View>( isPresented: Bool, @ViewBuilder content: @escaping () -> ToolbarContent) -> some View {
		modifier(BottomToolbarModifier(isPresented: isPresented, content: content))
	}
}
