import UIKit

struct WeatherSummary: Codable {

    struct Weather: Codable {
        struct Minutely: Codable {
            struct Sky: Codable {
                let code: String
                let name: String
            }
            struct Temperature: Codable {
                let tc: String
                let tmax: String
                let tmin: String
            }
            let sky: Sky
            let temperature: Temperature
        }
        let minutely: [Minutely]
    }

    struct Result: Codable {
        let code: Int
        let requestUrl: String
        let message: String
    }

    let weather: Weather
    let result: Result
}

let url = URL(string: "https://apis.openapi.sk.com/weather/current/minutely?version=1&lat=37.499206&lon=127.02761&appKey=c179df27-00da-4c16-83cd-65b71400de5c")!

//let session = URLSession.shared.dataTask(with: url)

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
        let summary = try decoder.decode(WeatherSummary.self, from: data)
        dump(summary)
    } catch {
        print(error.localizedDescription)
    }
}
task.resume()
