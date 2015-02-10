TransIt: time to get around
===========================
TransIt is a service that provides realtime departure times for public transportation in the Bay Area.

From the web or mobile browser, a transit rider—or transiteer—can find their station by navigating through the agency, route, and stop.

For other developers, there is an API that translates the 511 and NextBus APIs from XML to cross-site-available JSON.

Code
----
This is a **full-stack** Ruby on Rails + Backbone solution, leveraging Rails to serve html/assets, proxy API calls to 511 and NextBus, cache API calls for better performance, and store location data in a PostgreSQL database for searchability.

For the `/agencies` route, the initial page load is served by Rails, complete with assets and data from the API embedded in the `div#outlet`. When the page loads, Backbone renders the data into views. Routing to other paths causes Backbone to fetch new data from the API and render the template with that data as HTML.

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
/511/agencies -> List of agencies
/511/agencies/<agency name>/routes -> List of routes for that agency
/511/agencies/<agency name>/routes/<route code>/stops -> List of stops for that route
/511/agencies/departures/<stop id> -> List of departures for that stop

**NextBus**
