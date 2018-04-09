module Components.ListBtn exposing (..)

import Html exposing (Html, a, i)
import Html.Attributes exposing (class, href)
import Constants.Routes exposing (playersPath)
import Msgs exposing (Msg)


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href playersPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [] ]
