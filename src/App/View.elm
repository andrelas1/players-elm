module App.View exposing (..)

import Html exposing (Html, text, div)
import Html.Attributes exposing (class, id)
import Models.Models as Models exposing (Model, Player, PlayerId)
import Messages.Msgs as Msgs exposing (Msg)
import Pages.PlayersList as PlayersListPage
import Pages.PlayersEdit as PlayersEditPage
import Pages.PlayersCreate as PlayersCreatePage
import Pages.Login as Login
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
    div [ id "app" ] [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            PlayersListPage.view model.players

        Models.PlayerRoute id ->
            playerEditPage model id

        Models.NewPlayer ->
            PlayersCreatePage.view

        Models.LoginRoute ->
            Login.view

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
                        PlayersEditPage.view player

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            toString err |> text


notFoundView : Html Msg
notFoundView =
    div [] [ text "Not Found" ]
