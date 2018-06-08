module Pages.PlayersEdit exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages.Msgs as Msgs exposing (Msg)
import Models.Models as Models exposing (Player)
import Constants.Routes exposing (playersPath)


view : Player -> Html Msg
view player =
    div []
        [ nav
        , form player
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black p1" ] [ listBtn ]


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ h1 [] [ text player.name ]
        , formLevel player
        ]


formLevel : Player -> Html Msg
formLevel player =
    div [ class "clearfix py1" ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    a
        [ class "btn ml1 h1"
        , onClick <| Msgs.ChangeLevel player 1
        ]
        [ i [ class "fa fa-plus-circle" ] [] ]


btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    a
        [ class "btn ml1 h1"
        , onClick <| Msgs.ChangeLevel player -1
        ]
        [ i [ class "fa fa-minus-circle" ] [] ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href playersPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [] ]
