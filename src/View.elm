module View exposing (..)

import Html exposing (Html, text, div)
import Models exposing (Model, Player, PlayerId)
import Msgs exposing (Msg)
import Players.List
import Players.Edit
import List
import RemoteData


find : (Player -> Bool) -> List Player -> Maybe Player
find comparableFn list =
    list
        |> List.filter comparableFn
        |> List.head


playerName : Maybe Player -> String
playerName player =
    player
        |> Maybe.map .name
        |> Maybe.withDefault "Not Found"


view : Model -> Html Msg
view model =
    div [] [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            Players.List.view model.players

        Models.PlayerRoute id ->
            playerEditPage model id

        Models.NotFoundRoute ->
            notFoundView


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head
            in
                case maybePlayer of
                    Just player ->
                        Players.Edit.view player

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            toString err |> text


notFoundView : Html Msg
notFoundView =
    div [] [ text "Not Found" ]
