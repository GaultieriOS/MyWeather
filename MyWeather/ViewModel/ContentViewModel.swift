//
//  ContentViewModel.swift
//  MyWeather
//
//  Created by Gaultier Moraillon on 17/12/2024.
//

import Foundation
import UIKit

@MainActor
class ContentViewModel: ObservableObject {
    
    struct City: Identifiable {
        let id = UUID()
        let name: String
    }
    
    var cities: [City] = [
          //  City(name: "London")
        ]
    
    @Published var locationManager = LocationManager()
    @Published var weatherCity: [WeatherResponse] = []
    @Published var afficherPopup = false
    var newCityName: String = ""
    var weather: WeatherResponse?
    var weatherManager = WeatherManager()
    
    func getLocation() {
        locationManager.requestLocation()
    }
    
    func addCity() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        if !newCityName.isEmpty{
            let newCity = City(name: newCityName)
            cities.append(newCity)
            fetchNewCity(newCity: newCity.name)
        }
    }
    
    func fetchNewCity(newCity: String) {
        Task {
            do {
                weather = try await weatherManager.getWeatherCity(city: newCity)
                guard let weather = weather else { return }
                weatherCity.append(weather)
            }
            catch {
                print("Error getting weather: \(error)")
            }
        }
    }
    
    func fetchCurrentCity() async {
        if let location = locationManager.location {
            do {
                weather = try await weatherManager.getWeather(latitude: location.latitude, longitude: location.longitude)
            } catch {
                print("Error getting weather: \(error)")
            }
            guard let weather = weather else { return }
            weatherCity.append(weather)
            
            if let lastElement = weatherCity.popLast() {
                weatherCity.insert(lastElement, at: 0)
            }
        }
    }
    
    func fetchWeather() async {
        
        for city in cities {
            Task {
                do {
                    weather = try await weatherManager.getWeatherCity(city: city.name)
                    guard let weather = weather else { return }
                    weatherCity.append(weather)
                }
                catch {
                    print("Error getting weather: \(error)")
                }
            }
            print(weatherCity)
        }
    }
}
