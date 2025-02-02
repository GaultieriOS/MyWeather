//
//  ContentView.swift
//  MyWeather
//
//  Created by Gaultier Moraillon on 17/12/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var locationManager = LocationManager()
    @StateObject private var viewModel = ContentViewModel()
    @State private var afficherPopup = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter city name", text: $viewModel.newCityName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .onSubmit {
                            viewModel.addCity()
                            afficherPopup = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    afficherPopup = false
                                }
                            }
                        }
                    
                    Button {
                        Task {
                            viewModel.addCity()
                        }
                        afficherPopup = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                afficherPopup = false
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .padding()
                    }
                }
                if afficherPopup {
                    SuccessPopup()
                        .transition(.opacity)
                        .animation(.easeInOut, value: afficherPopup)
                }
                if viewModel.weatherCity.isEmpty {
                    Spacer()
                    Text("Veuillez renseigner une ville ou autoriser l'application à accéder à votre position")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                } else {
                    TabView {
                        ForEach (viewModel.weatherCity) { city in
                            WeatherView(weather: city)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.064, green: 0.1, blue: 0.486))
                    .preferredColorScheme(.dark)
                }
            }
        }
        .task {
            viewModel.getLocation()
            await viewModel.fetchWeather()
        }
        .onChange(of: locationManager.isAuthorized) {
            if locationManager.isAuthorized == true {
                Task {
                    await viewModel.fetchCurrentCity()
                }
            }
        }
    }

}

#Preview {
    HomeView()
}
