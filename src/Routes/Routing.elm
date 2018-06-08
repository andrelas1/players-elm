module Routes.Routing exposing (..)

import Navigation exposing (Location)
import Models.Models as Models exposing (PlayerId, Route(PlayersRoute, PlayerRoute, NewPlayer, LoginRoute, NotFoundRoute))
import UrlParser exposing (Parser, oneOf, map, (</>), s, string, parseHash, top)


playerPath : PlayerId -> String
playerPath id =
    "#player" ++ "/" ++ id


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map LoginRoute top
        , map PlayerRoute (s "player" </> string)
        , map PlayersRoute (s "players")
        , map NewPlayer (s "new-player")
        , map LoginRoute (s "login")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
