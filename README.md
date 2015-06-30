# gb-coding-challenge-nf

###Problem
The problem was to take a Guidebook API endpoint and retrieve guides from it in JSON. Then the JSON response should be parsed into an array of guide objects and displayed in a grouped table view showing name, city, state, and end date about each guide in each cell as well as showing the start date for all guides within each group as the section header title.

###Solution
I used two 3rd party libraries to accomplish this task in an easy and clean manner. One of those, iOSWebserviceTemplate, is a library that helps connect to an API and makes it easy to retrieve data from a URL. The other library I used, NSObject-ObjectMap, makes the task of turning JSON data into objects easy. Once I retrieved the JSON data and turned it into an array of guide objects I sorted the guides by start date in ascending order and grouped the guides by start date into a new array holding an array for each unique start date containing guides with that start from the guides in the guides array. Then I used the grouped guides array to populate my table view in a grouped manner displaying the start date of each group of guides in the header for each section. 
