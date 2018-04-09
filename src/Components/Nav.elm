module Components.Nav exposing (..)

import Html exposing (div, Html, text)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Components.ListBtn exposing (listBtn)


customNav : Bool -> String -> Maybe (Html Msg) -> Html Msg
customNav backBtn navTitle optBtn =
    div
        [ class "clearfix mb2 white bg-black p1" ]
        [ div [ class "left p2" ] [ text navTitle ]
        , if backBtn then
            listBtn
          else
            text ""
        , case optBtn of
            Just opt ->
                opt

            Nothing ->
                text ""
        ]
