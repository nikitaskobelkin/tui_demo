protocol NetworkingRequest {
    associatedtype ResponseType: Decodable
    func getRequestDescriptor() -> RequestDescriptor
}
