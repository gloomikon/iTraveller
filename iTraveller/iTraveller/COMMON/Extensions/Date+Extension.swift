import Foundation

extension Date {
    /// Returns a string representation of the date
    ///
    /// Example:
    ///
    /// `y, M d` - `2020, 10 29`
    ///
    /// `YY, MMM d` - `20, Oct 29`
    ///
    /// `YY, MMM d, hh:mm` -  `20, Oct 29, 02:18`
    ///
    /// `YY, MMM d, HH:mm:ss`  - `20, Oct 29, 14:18:31`
    ///
    /// `https://nsdateformatter.com/#reference`

    func toString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
