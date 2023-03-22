# VERO-Task-Interview
Write a iOS application that connects to a remote API, downloads a certain set of resources, shows them in a list and provides some basic searching/filtering feature-set. In particular, the app should:

Request the resources located at https://api.baubuddy.de/dev/index.php/v1/tasks/select
Store them in an appropriate data structure that allows using the application offline
Display all items in a list showing task, title, description and colorCode (which should be a view colored according to colorCode)
The app should offer a search bar that allows searching for any of the class properties (even those, that are not visible to the user directly)
The app should offer a menu item that allows scanning for QR-Codes 
Upon successful scan, the search query should be set to the scanned text
In order to refresh the data, the app should offer a pull-2-refresh functionality (VERO-Digital-Solutions (2023), https://github.com/VERO-Digital-Solutions/ios-task)

# Dependencies
iOS13<=

# Authors
@tahirkizir https://www.linkedin.com/in/tahir-kizir-82a05921a/

# Version History 
0.1 Initial release
