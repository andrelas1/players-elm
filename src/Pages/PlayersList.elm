module Pages.PlayersList exposing (view)

import Html exposing (div, text, table, thead, td, tr, th, Html, tbody, i, a)
import Html.Attributes exposing (class, href)
import Messages.Msgs as Msgs exposing (Msg)
import Models.Models as Models exposing (Player)
import RemoteData exposing (WebData)
import Routes.Routing as Routes exposing (playerPath)
import Constants.Routes exposing (createPlayerPath)
import Components.Nav exposing (customNav)


view : WebData (List Player) -> Html Msg
view response =
    div []
        [ customNav False "Players" (Just newPlayerBtn)
        , maybeList response
        ]


maybeList : WebData (List Player) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success players ->
            list players

        RemoteData.Failure error ->
            text (toString error)


newPlayerBtn : Html Msg
newPlayerBtn =
    div [ class "right p2" ]
        [ a [ class "btn regular", href createPlayerPath ] [ i [ class "fa fa-plus mr1" ] [] ] ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Players" ]
        , div
            [ class "right p2" ]
            [ a [ class "btn regular", href createPlayerPath ] [ i [ class "fa fa-plus mr1" ] [] ] ]
        ]


list : List Player -> Html Msg
list players =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "ID" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map playerRow players)
            ]
        ]


playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text player.id ]
        , td [] [ text player.name ]
        , td [] [ text <| toString <| player.level ]
        , td [] [ editBtn player ]
        ]


editBtn : Player -> Html Msg
editBtn player =
    let
        path =
            playerPath player.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ i [ class "fa fa-pencil mr1" ] [] ]



-- UPDATE
-- SUBSCRIPTIONS
