# gb-coding-challenge-nf

###Problem
The problem was to take a Guidebook API endpoint and retrieve Guides in JSON, parse the JSON data into an array of object, and display in a table view showing name, city, state, start date, and end date about each guide.

###Solution
I used two 3rd party libraries to accomplish this task in an easy and clean manner. One of those, iOSWebserviceTemplate, is a library that helps connect to an API and makes it easy to retrieve data from a URL. The other library is used, NSObject-ObjectMap, makes the task of turning JSON data into objects easy. Once I retrieved the JSON data and turned it into an array of guide objects I sorted the guides by start date in ascending order and grouped the guides by start date into a new array holding and array for each unique start date within the guides in the guides array. Then I used the grouped guides array to populate my table view in a grouped manner displaying the start date of each group of guides in the header for each section. 
