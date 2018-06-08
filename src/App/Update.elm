module App.Update exposing (..)

import Models.Models as Models exposing (Model, Player)
import Messages.Msgs as Msgs exposing (Msg)
import Routes.Routing as Routing exposing (parseLocation)
import RemoteData exposing (WebData)
import List
import App.Commands as Commands exposing (savePlayerCmd, createPlayerCmd, fetchPlayers, loginUser)


-- HANDLES THE STATE OF THE APPLICATION


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

        Msgs.NewPlayer player ->
            ( model, createPlayerCmd player )

        Msgs.OnPlayerCreate (Ok player) ->
            ( model, fetchPlayers )

        Msgs.OnPlayerCreate (Err error) ->
            ( model, Cmd.none )

        Msgs.OnPlayerDelete playerId ->
            ( model, Cmd.none )

        Msgs.OnLoginSubmit ->
            ( model, loginUser model.user )

        Msgs.OnUsernameChange un ->
            let
                outdatedUser =
                    model.user

                updatedUser =
                    { outdatedUser | username = un }
            in
                ( { model | user = updatedUser }, Cmd.none )

        Msgs.OnPasswordChange pw ->
            let
                outdatedUser =
                    model.user

                updatedUser =
                    { outdatedUser | password = pw }
            in
                ( { model | user = updatedUser }, Cmd.none )


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
