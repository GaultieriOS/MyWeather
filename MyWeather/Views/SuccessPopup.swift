//
//  SuccessPopup.swift
//  MyWeather
//
//  Created by Gaultier Moraillon on 02/02/2025.
//

import SwiftUI

struct SuccessPopup: View {
    var body: some View {
        VStack {
            Text("✅ Ville ajoutée")
                .font(.headline)
                .padding()
                .background(Color.green.opacity(0.9))
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Remplit tout l'écran
        .background(Color.black.opacity(0.4)) // Fond semi-transparent
        .edgesIgnoringSafeArea(.all) // Ignore les safe areas
    }
}
