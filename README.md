# Téléo+ consumption
Scrapping of Téléo+ services to fetch your water index

## Why?
Because that's my fucking freaking data I produce and pay for, that's fucking why! Why using a proprietary format? Why can't I just read my fucking counter? Damn you Veolia!

## How?
You must: 
* be customer at Veolia Eau
* having a water counter with a emitting module
* enabled the Téléo+ service

## The script
You can't do simpler. Either ran it via command line (provide your username and password as env variables) or include the class in your project and call 
`TeleoScrapper.run`
You'll get a sorted by date Array of arrays. Each array has its first element as date and the second a hash with keys "val" dans "est" the first is the index for the date, the second tell you if it's estimated or a real data read from your counter.
