import Analytics

class AnalyticsService {

    private let analyticsService: Analytics.AnalyticsService

    init(analyticsService: Analytics.AnalyticsService) {
        self.analyticsService = analyticsService
    }

    func send(_ event: iTravallerEvent) {
        analyticsService.send(event)
    }
}
