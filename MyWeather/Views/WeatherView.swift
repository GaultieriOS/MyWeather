//
//  WeatherView.swift
//  MyWeather
//
//  Created by Gaultier Moraillon on 17/12/2024.
//

import SwiftUI

struct WeatherView: View {
    var weather: WeatherResponse
    
    var body: some View {
            ZStack(alignment: .leading) {
                VStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(weather.name)
                            .bold()
                            .font(.title)
                        Text("Today, \(Date().formatted(.dateTime.day().month().hour().minute()))")
                            .fontWeight(.light)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                Image(systemName: "cloud.fill")
                                    .font(.system(size: 50))
                                
                                Text(weather.weather[0].main)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            Text(weather.main.feelsLike.roundDouble() + "°")
                                .font(.system(size: 100))
                                .fontWeight(.bold)
                                .padding()
                        }
                        
                        Spacer()
                            .frame(height: 80)
                        
                        Image(.city)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Weather now")
                            .bold().padding(.bottom)
                        
                        HStack {
                            WeatherRow(logo: "thermometer.low", name: "Min temp", value: (weather.main.tempMin.roundDouble() + "°"))
                            Spacer()
                            WeatherRow(logo: "thermometer.high", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                        }
                        
                        HStack {
                            WeatherRow(logo: "wind", name: "Wind Speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                            Spacer()
                            WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.description + "%"))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(Color(red: 0.064, green: 0.1, blue: 0.486))
                    .background(.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color(red: 0.064, green: 0.1, blue: 0.486))
            .preferredColorScheme(.dark)
        }
}

#Preview {
    WeatherView(weather: previewWeather)
}
