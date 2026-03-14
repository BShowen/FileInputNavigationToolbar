//
//  ToolbarButton.swift
//  FieldInputNavigationToolbar
//
//  Created by Bradley Showen on 3/14/26.
//

import SwiftUI

struct ToolbarButton: View {
	
	let isDisabled: Bool
	let onTap: () -> Void
	let systemImage: String
	
    var body: some View {
		Button {
			onTap()
		} label: {
			Image(systemName: systemImage)
				.resizable()
				.scaledToFit()
				.frame(width: 20, height: 20)
				.padding()
				.contentShape(Rectangle())
		}
		.buttonStyle(.plain)
		.disabled(isDisabled)
    }
}

#Preview {
	ToolbarButton(isDisabled: false, onTap: {}, systemImage: "chevron.up")
}
