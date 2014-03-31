var access_key = "";

chrome.runtime.onMessage.addListener(function(request, sender, sendResponse) {
  // Update Chrome Badge Text.
  access_key = request.messages.access_token;
});

function check(tabId, changeInfo, tab) {
  user = tab.url.split("/")[3]
  repo = tab.url.split("/")[4]

  if (tab.url.indexOf('github.com/') > -1 && user && repo) {
    chrome.pageAction.show(tabId);
  }
}

chrome.tabs.onUpdated.addListener(check);
