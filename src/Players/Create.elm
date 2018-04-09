module Players.Create exposing (..)

import Html exposing (div, text, a, span, i, input, Html)
import Html.Attributes exposing (placeholder, type_, class)
import Components.Nav exposing (customNav)
import Msgs exposing (Msg)


view : Html Msg
view =
    div
        []
        [ customNav True "New Player" Nothing
        , input [ type_ "text", placeholder "name" ] []
        , input [ type_ "number", placeholder "level" ] []
        ]
