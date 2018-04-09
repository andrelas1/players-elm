module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)
import Models exposing (Player)
import Constants.Routes exposing (playersPath)
import Msgs exposing (..)


view : Player -> Html Msg
view player =
    div []
        [ nav player
        , form player
        ]


nav : Player -> Html Msg
nav player =
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
