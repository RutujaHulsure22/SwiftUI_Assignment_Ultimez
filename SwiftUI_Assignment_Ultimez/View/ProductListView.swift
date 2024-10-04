import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.listings) { listing in
                NavigationLink(destination: ProductDetailView(product: listing)) {
                    HStack {
                        AsyncImage(url: URL(string: listing.imageURLsThumbnails.first ?? "")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        } placeholder: {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 50, height: 50)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(listing.name)
                                .font(.headline)
                            Text(listing.price)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle(Constants.commonString.appTitle)
            .onAppear {
                Task {
                    await viewModel.fetchProducts()
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView(Constants.commonString.loading)
                }
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage).foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    ProductListView()
}
