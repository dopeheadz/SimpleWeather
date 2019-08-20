//
//  WeatherDataSource.swift
//  SimpleWeather
//
//  Created by dope on 20/08/2019.
//  Copyright © 2019 dope. All rights reserved.
//

import Foundation

class WeatherDataSource {
    static let shared = WeatherDataSource()
    private init() { }

    var summary: WeatherSummary?
    var forecastList = [Any]()

    func fetchSummary(lat: Double, lon: Double, completion: @escaping () -> ()) {

        let url = URL(string: "https://apis.openapi.sk.com/weather/current/minutely?version=1&lat=\(lat)&lon=\(lon)&appKey=\(apiKey)")!

        //let session = URLSession.shared.dataTask(with: url)

        let session = URLSession.shared

        let task = session.dataTask(with: url) { (data, response, error) in

            defer { // defer: 스코프가 종료되기전에 실행
                DispatchQueue.main.async {
                    completion()
                }
            }

            // 순서
            // #1 에러 확인
            if let error = error {
                print(error)
                return
            }

            // #2
            // response 확인
            // 200 ~ 299 사이
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError("invalid Response")
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                fatalError("\(httpResponse.statusCode)")
            }

            guard let data = data else {
                fatalError("Invalid Data")
            }

            do {
                let decoder = JSONDecoder()
                let summary = try decoder.decode(WeatherSummary.self, from: data)
//                dump(summary)
                self.summary = summary


            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()

    }
    
    func fetchForecast(lat: Double, lon: Double, completion: @escaping () -> ()) {
        forecastList.removeAll() // 배열 초기화
        
        let url = URL(string: "https://apis.openapi.sk.com/weather/forecast/3days?version=1&lat=\(lat)&lon=\(lon)&appKey=\(apiKey)")!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            // 순서
            // #1 에러 확인
            if let error = error {
                print(error)
                return
            }
            
            // #2
            // response 확인
            // 200 ~ 299 사이
            guard let httpResponse = response as? HTTPURLResponse else {
                fatalError("invalid Response")
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                fatalError("\(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                fatalError("Invalid Data")
            }
            
            do {
                let decoder = JSONDecoder()
                let forecast = try decoder.decode(Forecast.self, from: data)
                dump(forecast)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()

        
    }
}
