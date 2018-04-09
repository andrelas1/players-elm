module Msgs exposing (..)

import Navigation exposing (Location)
import Models exposing (Player, PlayerId)
import RemoteData exposing (WebData)
import Http


type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | ChangeLevel Player Int
    | NewPlayer Player
    | OnPlayerSave (Result Http.Error Player)
    | OnPlayerCreate (Result Http.Error Player)
    | OnPlayerDelete (Result Http.Error ())
