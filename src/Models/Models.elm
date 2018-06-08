module Models.Models exposing (..)

import RemoteData exposing (WebData)


type Route
    = LoginRoute
    | PlayersRoute
    | PlayerRoute PlayerId
    | NewPlayer
    | NotFoundRoute


type alias Model =
    { players : WebData (List Player)
    , user : User
    , route : Route
    }


initialModel : Route -> User -> Model
initialModel route user =
    { players = RemoteData.Loading
    , user = user
    , route = route
    }


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


type alias User =
    { username : String
    , password : String
    , id : PlayerId
    }
