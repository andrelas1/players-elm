module Players.List exposing (..)

import Html exposing (div, text, table, thead, td, tr, th, Html, tbody, i, a)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models exposing (Player)
import RemoteData exposing (WebData)
import Routing exposing (playerPath)


-- MODEL
-- VIEW
--findPlayer : String -> List Player -> Maybe Player
--findPlayer playerId players =
--    List.foldl
--        (\player memo ->
--            case memo of
--                Just _ ->
--                    memo
--                Nothing ->
--                    if playerId == player.id then
--                        Just player
--                    else
--                        Nothing
--        )
--        Nothing
--        players
--playerName : Maybe Player -> String
--playerName player =
--    case player of
--        Just player ->
--            player.name
--        Nothing ->
--            "Not found"
--div []
--    [ find (\player -> player.id == "1") model.players
--        |> playerName
--        |> text
--    ]


view : WebData (List Player) -> Html Msg
view response =
    div []
        [ nav
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


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ]
            [ text "Players" ]
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
