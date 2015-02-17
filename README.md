TransIt: time to get around
===========================
TransIt is a service that provides realtime departure times for public transportation in the Bay Area.

From the web or mobile browser, a transit rider—or transiteer—can find their station by navigating through the agency, route, and stop.

For other developers, there is an API that translates the 511 and NextBus APIs from XML to cross-site-available JSON.

Code
----
This is a **full-stack** Ruby on Rails + Backbone solution, leveraging Rails to serve html/assets, proxy API calls to 511 and NextBus, cache API calls for better performance, and store location data in a PostgreSQL database for searchability.

For the `/agencies` route, the initial page load is served by Rails, complete with assets and data from the API embedded in the `div#outlet`. When the page loads, Backbone renders the data into views. Routing to other paths causes Backbone to fetch new data from the API and render the template with that data as HTML.

For the '/nearby' route, the first thing that happens is geolocating in the browser. Geolocating on the server seems hardly as reliable. As such, Rails does not know what data to server until the geolocating is done. When that happens, Backbone sends a request to the `/v1` API to get stops near the geolocated latitude and longitude. Since there was no evident way to do this through NextBus, the Rails server has the stops in the database and can query them using the Ruby Geocoder gem. Once the request comes back with the stops, requests are fired for each stop to the `/nb/:agency_tag/

For the server, I knew Rails pretty well and Node less so. I chose Rails so that the server layer could stay out of the way and I could focus on playing around with integrating the backend and the frontend—which is something I've been interested in for a while.

For the frontend, I chose Backbone. I had worked with it before—but primarily in its Marionette incarnation. The backbone-on-rails gem helped get the directory structure in place.


The Author: Evan Kuchar
-----------------------
I taught myself Ruby on Rails to build a rideshare (think in*ter*city, not in*tra*) in 2012.
<br>You can still see that code [here](https://github.com/evanboho/hithr.to). And you can see the site [here](http://hithr.herokuapp.com/).
<br>So much box shadow; so wow.

Since then, I've worked for [startups](https://dabble.co) and [SaaS](http://www.granicus.com/) companies but that code is not public.

The most recent app I've made allows a twitter user—or tweeter—to give access to another tweeter—or twitter user—to send tweets *as* them.
The code is [here](https://github.com/evanboho/140x) and the site lives on my Digital Ocean droplet [here](http://140x140.net/).

API
---
**511**
<br>/511/agencies -> List of agencies
<br>/511/agencies/:agency_name/routes -> List of routes for that agency
<br>/511/agencies/:agency_name/routes/:route_code(/:direction)/stops -> List of stops for that route. If the Route has a direction, then direction is required.
<br>/511/departures/:stop_id -> List of departures for that stop


**NextBus**
<br>/nb/agencies -> List of agencies
<br>/nb/agencies/:agency_tag/routes -> List of routes
<br>/nb/agencies/:agency_tag/routes/:route_tag/stops -> List of stops
<br>/nb/agencies/:agency_tag/routes/:route_tag/stops/:stop_id/departures -> List of Departures
<br>/nb/agencies/:agency_tag/departures/:stop_id -> Short path to same list of Departures

Problems? Solutions.
--------------------
To reference an image in Rails, you need its digest—a hash appended to the file name to allow for both caching and cache busting. Not having access to the Rails image path helpers in the Javascript template, I made a hash of image paths with digest in a script tag to then have access to it in the Javascript.

**TODO**: Add a BART API for both a proxy and a way of importing stops for geolocating.

**TODO**: Add specs for Nearby.

**TODO**: Add active class to Browse links.

Contributing
------------
Fork it. Pull Request it.

You'll need Rails 4.2 and Postgres.
