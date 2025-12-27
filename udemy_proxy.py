"""
mitmproxy addon to make requests look like they come from a real browser
Usage: mitmproxy -s udemy_proxy.py --listen-port 8888
"""

from mitmproxy import http

class UdemyProxy:
    def request(self, flow: http.HTTPFlow) -> None:
        # Only modify requests to Udemy
        if "udemy.com" in flow.request.pretty_host:
            # Add browser-like headers
            flow.request.headers["sec-ch-ua"] = '"Chromium";v="122", "Not(A:Brand";v="24", "Google Chrome";v="122"'
            flow.request.headers["sec-ch-ua-mobile"] = "?0"
            flow.request.headers["sec-ch-ua-platform"] = '"macOS"'
            flow.request.headers["sec-fetch-dest"] = "empty"
            flow.request.headers["sec-fetch-mode"] = "cors"
            flow.request.headers["sec-fetch-site"] = "same-origin"

            # Upgrade user agent
            flow.request.headers["user-agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"

addons = [UdemyProxy()]
