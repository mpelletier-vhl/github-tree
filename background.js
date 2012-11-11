function check(tabId, changeInfo, tab) {
  //if (tab.url.indexOf('github.com') > -1) {
    chrome.pageAction.show(tabId);
  //}
}

chrome.tabs.onUpdated.addListener(check);
