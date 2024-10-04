import SwiftUI

struct ProductDetailView: View {
    var product: Product
    let conversionRate: Double = 83.0
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: product.imageURLs.first ?? "")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom)
                
                Text(product.name)
                    .font(.largeTitle)
                    .padding(.bottom)
                
                if let priceInUSD = extractPrice(from: product.price) {
                    let priceInINR = priceInUSD * conversionRate
                    Text("Price: \(String(format: "%.2f", priceInUSD)) USD (\(String(format: "%.2f", priceInINR)) INR)")
                        .font(.title2)
                        .padding(.bottom)
                        .foregroundColor(.gray)
                } else {
                    Text("Price: \(product.price)")
                        .font(.title2)
                        .padding(.bottom)
                        .foregroundColor(.gray)
                }
                
                if let formattedDate = formatDate(product.createdAt) {
                    Text("Created At: \(formattedDate)")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.bottom)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(Constants.commonString.productDetails)
    }
    
    
    private func extractPrice(from priceString: String) -> Double? {
        let pattern = "[0-9.]+"
        let regex = try? NSRegularExpression(pattern: pattern)
        let nsString = priceString as NSString
        let results = regex?.matches(in: priceString, range: NSRange(location: 0, length: nsString.length))
        
        if let match = results?.first {
            let priceValue = nsString.substring(with: match.range)
            return Double(priceValue)
        }
        return nil
    }
    
    private func formatDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.commonString.dateformat
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        dateFormatter.dateFormat = Constants.commonString.expectedDateFormat
        return dateFormatter.string(from: date)
    }
}

#Preview {
    let mockProduct = Product(id: "1", price: "10.00", name: "Mock Product", createdAt: "2024-10-04", imageIDs: [], imageURLs: ["https://via.placeholder.com/150"], imageURLsThumbnails: [])
    ProductDetailView(product: mockProduct)
}
