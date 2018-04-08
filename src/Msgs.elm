module Msgs exposing (..)

import Navigation exposing (Location)
import Models exposing (Player)
import RemoteData exposing (WebData)
import Http


type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
