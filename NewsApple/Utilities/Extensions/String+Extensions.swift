import Foundation

extension String {
    func formattedDate() -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            outputFormatter.timeStyle = .none
            return outputFormatter.string(from: date)
        }
        return self
    }
}
