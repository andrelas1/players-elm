module Update exposing (..)

import Models exposing (Model, Player)
import Msgs exposing (Msg)
import Routing exposing (parseLocation)
import RemoteData exposing (WebData)
import List
import Commands exposing (savePlayerCmd)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            ( { model | route = (parseLocation location) }, Cmd.none )

        Msgs.ChangeLevel player newLevel ->
            let
                newPlayer =
                    { player | level = player.level + newLevel }
            in
                ( model, savePlayerCmd newPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        comparableFn currentPlayer =
            if currentPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map comparableFn players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }
