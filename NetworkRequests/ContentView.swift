import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var value: String = "Waiting"
    
    var body: some View {

        VStack(alignment: .center) {
            Text("Example Application")
            
            Button(action: {
                if let url = URL(string: "https://api.postcodes.io/random/postcodes") {
                    var request = URLRequest(url: url)
                    request.addValue("AWSCognitoIdentityProviderService.InitiateAuth", forHTTPHeaderField: "x-amz-target")
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        if let data = data {
                            do {
                                if let jsonString = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                    if let names = jsonString["result"] as? [String: Any] {
                                        let postcode = names["postcode"]! as! String
                                        print(postcode)
                                        self.value = postcode
                                    }
                                    print(jsonString)
                                }
                            } catch let error as NSError {
                                print("Failed to load: \(error.localizedDescription)")
                            }
                        }
                    }.resume()
                }
            }) {
                Text("Fetch Postcode")
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .font(.title)
                    .border(Color.black, width: 2)
            }
            
            Text("The postcode will be displayed below after the network request has completed")
            
            TextField("Display Random Postcode", text: $value).multilineTextAlignment(.center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
