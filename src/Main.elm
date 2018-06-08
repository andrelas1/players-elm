module Main exposing (..)

import App.View as View exposing (view)
import App.Update as Update exposing (update)
import App.Commands as Commands exposing (fetchPlayers)
import App.Subscriptions as Subscriptions exposing (subscriptions)
import Models.Models as Models exposing (Model, initialModel, User)
import Messages.Msgs as Msgs exposing (Msg)
import Navigation exposing (Location)
import Routes.Routing as Routing


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute user, fetchPlayers )


user : User
user =
    { id = ""
    , username = ""
    , password = ""
    }



-- MAIN


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
