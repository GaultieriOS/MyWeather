//
//  WeatherManager.swift
//  MyWeather
//
//  Created by Gaultier Moraillon on 17/12/2024.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    let appID = "82125178fcc05780625e4459f6097e2f"
    
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherResponse {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(appID)&units=metric") else {
            fatalError("Invalid URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return decodedData
    }
    
    func getWeatherCity(city: String) async throws -> WeatherResponse {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(appID)&units=metric") else {
            fatalError("Invalid URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return decodedData
    }
}
