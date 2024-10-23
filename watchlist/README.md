# watchlist

## Intro
We're hoping to make watchlist, an app that allows a group of people to intersect their movie “watchlists” in order to find a film that none of them have seen (but they all would like to watch). The app will compile Letterboxd* data and movie availability data to efficiency suggest movies and where to watch them.

## Function
- uses Letterboxd API to retrieve a user’s data (movies watched, watchlist, favorite movies, ratings)
- can pull multiple users’ data to find movies that are no one has watched / that are in everyone's watchlist / movies they have watched but really liked and would watch again
- can filter movie by platformCan recommend movies that are similar to the types on both/all people’s watchlists
- instead of having friends, we will be signing in to all accounts on one phone to eliminate the need for hosting data somewhere

## Technologies/API
API Calls

## Sources of Complexity
- the Letterboxd API will require us to input a username and password; we will also need access tokens
- we will be signing in with multiple accounts so we will need to create both movie, account, and linking tables
- we might need to also make another API call to IMDB to retrieve where you can watch the movies as this feature is premium on Letterboxd


* *Letterboxd is an online app that is essentially Goodreads but for movies
